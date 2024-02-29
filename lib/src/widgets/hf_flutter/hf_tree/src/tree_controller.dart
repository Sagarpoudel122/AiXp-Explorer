// ignore_for_file: public_member_api_docs, sort_constructors_first
part of hf_tree;

const int treeRootLevel = 0;

typedef Visitor<T> = void Function(T node);
typedef NodeMatchCondition<T> = bool Function(T node);

class TreeControllerEvent extends ChangeNotifier {
  void handle() {
    if (super.hasListeners) {
      super.notifyListeners();
    }
  }
}

class TreeController<TreeKeyType, TreeValueType extends Object> with ChangeNotifier {
  TreeController({
    this.syncChildCheckboxWithParent = true,
    this.onSelectionChanged,
    this.onItemCheckChanged,
  });

  final TreeControllerEvent onFilterUpdate = TreeControllerEvent();
  final void Function(TreeItem<TreeKeyType, TreeValueType> item, {TreeKeyType? oldItem})? onSelectionChanged;
  final void Function(TreeItem<TreeKeyType, TreeValueType> item, bool value)? onItemCheckChanged;

  TreeItems<TreeKeyType, TreeValueType> items = TreeItems<TreeKeyType, TreeValueType>();
  TreeItemFilter<TreeKeyType, TreeValueType>? _filterCondition;
  FilterResultSetNewChildren<TreeValueType>? _setNewChildren;
  FilterResultRemoveChildren<TreeValueType>? _removeChildren;

  void filter({
    required TreeItemFilter<TreeKeyType, TreeValueType> condition,
    required FilterResultSetNewChildren<TreeValueType> setNewChildren,
    required FilterResultRemoveChildren<TreeValueType> removeChildren,
    bool shouldRebuild = true,
  }) {
    if (!items.isFiltered) {
      // Save expanded items before applying first filter
      _expandedItemsBeforeFilter = Set<TreeKeyType>.from(_expandedItems);
    }
    clearExpandedItems();
    _filterCondition = condition;
    _setNewChildren = setNewChildren;
    _removeChildren = removeChildren;
    applyFilter();

    handleFilterUpdate(shouldRebuild: shouldRebuild);
  }

  void applyFilter() {
    if (_filterCondition == null || _setNewChildren == null || _removeChildren == null) {
      debugPrint('No filter to apply');
      return;
    }

    items.filter(condition: _filterCondition!);
  }

  void clearFilter() {
    _filterCondition = null;
    _setNewChildren = null;
    _removeChildren = null;
    items.clearFilter();
    // Restore expanded items before filter
    _expandedItems = Set<TreeKeyType>.from(_expandedItemsBeforeFilter);
    handleFilterUpdate();
  }

  bool get animateExpandCollapse => _animateExpandCollapse;
  bool _animateExpandCollapse = true;

  /// Returns the filteredRoots if a filter is set
  /// or the tree roots otherwise

  void handleFilterUpdate({bool shouldRebuild = true}) {
    onFilterUpdate.handle();
    if (shouldRebuild) {
      rebuild(animate: false);
    }
  }

  final Set<TreeKeyType> _loadingItems = <TreeKeyType>{};
  Set<TreeKeyType> _expandedItems = <TreeKeyType>{};
  Set<TreeKeyType> _expandedItemsBeforeFilter = <TreeKeyType>{};

  bool isItemLoading(TreeItem<TreeKeyType, TreeValueType> item) {
    return _loadingItems.contains(item.key);
  }

  void setItemLoading(TreeItem<TreeKeyType, TreeValueType> item, {required bool loading}) {
    loading ? _loadingItems.add(item.key) : _loadingItems.remove(item.key);
  }

  bool isItemExpanded(TreeItem<TreeKeyType, TreeValueType> item) {
    return _expandedItems.contains(item.key);
  }

  void setItemExpanded(TreeItem<TreeKeyType, TreeValueType> item, {required bool expanded}) {
    expanded ? _expandedItems.add(item.key) : _expandedItems.remove(item.key);
  }

  Future<void> toggleItemExpanded(TreeItem<TreeKeyType, TreeValueType> item) async {
    bool isAlreadyExpanded = isItemExpanded(item);
    // If we want to expand the item and its children need to be loaded
    // then load them and expand it after
    if (!isAlreadyExpanded && item.needsToLoadChildren) {
      setItemLoading(item, loading: true);
      rebuild();
      await item.loadChildren();
      setItemLoading(item, loading: false);
      setItemExpanded(item, expanded: !isAlreadyExpanded);
      rebuild();
    } else {
      // Otherwise simply expand it
      setItemExpanded(item, expanded: !isAlreadyExpanded);
      rebuild();
    }
  }

  void clearExpandedItems() {
    _expandedItems.clear();
  }

  final Set<TreeKeyType> _checkedItemsIds = <TreeKeyType>{};
  final Set<TreeKeyType> _indeterminateItemsIds = <TreeKeyType>{};

  bool? getCheckboxValueForId(TreeKeyType id) {
    // Check in checked items list
    if (_checkedItemsIds.contains(id)) {
      return true;
    }
    // Check in indeterminate items list
    if (_indeterminateItemsIds.contains(id)) {
      return null;
    }
    // If not found in the two sets, then it must be unchecked
    return false;
  }

  bool? getCheckboxValue(TreeItem<TreeKeyType, TreeValueType> item) => getCheckboxValueForId(item.key);

  void setCheckboxValueForId(TreeKeyType id, {required bool? value}) {
    switch (value) {
      case true:
        _checkedItemsIds.add(id);
        _indeterminateItemsIds.remove(id);
        break;
      case null:
        _checkedItemsIds.remove(id);
        _indeterminateItemsIds.add(id);
        break;
      case false:
        _checkedItemsIds.remove(id);
        _indeterminateItemsIds.remove(id);
    }
  }

  void updateAncestorsCheckboxesToReflectChildren(TreeItem<TreeKeyType, TreeValueType> item) {
    final parent = item.parent;
    if (parent == null) {
      return;
    }
    updateItemCheckboxToReflectChildren(parent);
    updateAncestorsCheckboxesToReflectChildren(parent);
  }

  void updateItemCheckboxToReflectChildren(TreeItem<TreeKeyType, TreeValueType> item) {
    bool? newCheckedState;
    final Iterable<TreeItem<TreeKeyType, TreeValueType>> children = item.children;

    // In case we don't have any children, do it for the parent
    if (children.isEmpty) {
      updateAncestorsCheckboxesToReflectChildren(item);
      return;
    }

    for (final currentChild in children) {
      final bool? siblingCheckedState = getCheckboxValueForId(currentChild.key);
      if (siblingCheckedState == null) {
        // If the current child sibling is indeterminate then the
        // item is indeterminate
        newCheckedState = null;
        break;
      } else
        // The current child sibling checked state is true or false
        // Check if the newCheckedState state is null/indeterminate
      if (newCheckedState == null) {
        // If it is indeterminate then set it
        // to the current sibling checked state (true or false)
        if (syncChildCheckboxWithParent) {
          newCheckedState = siblingCheckedState;
        }
      } else
        // If new checked state is not indeterminate then
        // compare it to current child sibling checked state and see if it is
        // different. If different, then the new item checked state
        // should be indeterminate (null)
      if (newCheckedState != siblingCheckedState) {
        newCheckedState = null;
        break;
      }
    }

    final bool? currentCheckedState = getCheckboxValueForId(item.key);
    if (currentCheckedState != newCheckedState) {
      setCheckboxValueForId(item.key, value: newCheckedState);
      // Also do it for the parent
      updateAncestorsCheckboxesToReflectChildren(item);
    }
  }

  void updateAncestorsIndeterminateStateToReflectChildren(TreeItem<TreeKeyType, TreeValueType> item) {
    final parent = item.parent;
    if (parent == null) {
      return;
    }
    updateIndeterminateStateToReflectChildren(parent);
    // Do it for the other parents
    updateAncestorsIndeterminateStateToReflectChildren(parent);
  }

  void updateIndeterminateStateToReflectChildren(TreeItem<TreeKeyType, TreeValueType> item) {
    final Iterable<TreeItem<TreeKeyType, TreeValueType>> children = item.children;

    // In case we don't have any children, return
    if (children.isEmpty) {
      return;
    }

    final bool? prevCheckboxValue = getCheckboxValueForId(item.key);
    // If the item is checked then there is no need to set is as indeterminate
    if (prevCheckboxValue ?? false) {
      return;
    }

    bool hasAtLeastOneCheckedOrIndeterminate = false;

    for (final currentChild in children) {
      final bool? checkboxValue = getCheckboxValue(currentChild);
      // Check if it is true or indeterminate
      if (checkboxValue ?? true) {
        hasAtLeastOneCheckedOrIndeterminate = true;
        break;
      }
    }
    if (hasAtLeastOneCheckedOrIndeterminate == true) {
      // Set is as indeterminate
      setCheckboxValueForId(item.key, value: null);
    } else {
      // Otherwise set it as unchecked if it is not checked already
      if (getCheckboxValueForId(item.key) != true) {
        setCheckboxValueForId(item.key, value: false);
      }
    }
  }

  bool syncChildCheckboxWithParent = true;

  void setItemCheckboxValue(TreeItem<TreeKeyType, TreeValueType> item,
      {required bool value, bool includeChildren = false}) {
    final Iterable<TreeItem<TreeKeyType, TreeValueType>> children = item.children;

    // Update item
    setCheckboxValueForId(item.key, value: value);

    // Update children
    if (children.isNotEmpty) {
      if (includeChildren) {
        items.visitChildrenWithAction(
          startingItem: item,
          actionBeforeVisit: (TreeItem<TreeKeyType, TreeValueType> currentChild) {
            setCheckboxValueForId(currentChild.key, value: value);
          },
        );
      } else {
        if (value == false) {
          updateIndeterminateStateToReflectChildren(item);
        }
      }
    }

    // Update parent
    if (syncChildCheckboxWithParent) {
      updateAncestorsCheckboxesToReflectChildren(item);
    } else {
      updateAncestorsIndeterminateStateToReflectChildren(item);
    }

    rebuild();
  }

  void toggleItemCheckbox(TreeItem<TreeKeyType, TreeValueType> item) {
    final bool? currentValue = getCheckboxValue(item);
    setItemCheckboxValue(item, value: currentValue == null || !currentValue);
    rebuild();
  }

  /// Override this to enable multiple selection support
  bool isMultiSelectEnabled() {
    return false;
  }

  final Set<TreeKeyType> _selectedItems = <TreeKeyType>{};

  void selectItem(TreeItem<TreeKeyType, TreeValueType> item) => setItemSelected(item, value: true);

  void deselectItem(TreeItem<TreeKeyType, TreeValueType> item) => setItemSelected(item, value: false);

  bool isItemSelected(TreeItem<TreeKeyType, TreeValueType> item) => _selectedItems.contains(item.key);

  void setItemSelected(TreeItem<TreeKeyType, TreeValueType> item, {required bool value}) {
    // Clear the selected items if only multi-selection is not supported

    var oldSelection;

    if (!isMultiSelectEnabled()) {
      oldSelection = Set.from(_selectedItems).firstOrNull;
      _selectedItems.clear();
      rebuild();
    }
    value ? _selectedItems.add(item.key) : _selectedItems.remove(item.key);
    onSelectionChanged?.call(item, oldItem: oldSelection);
  }

  void notifyItemCheckedChange(TreeItem<TreeKeyType, TreeValueType> item, {required bool checked}) {
    onItemCheckChanged?.call(item, checked);
  }

  /// Notify listeners that the tree structure changed
  void rebuild({bool animate = true}) {
    // Temporarily disable/enable expand/collapse animation
    final bool previousValue = animateExpandCollapse;
    _animateExpandCollapse = animate;
    notifyListeners();
    _animateExpandCollapse = previousValue;
  }

  void _collapse(TreeItem<TreeKeyType, TreeValueType> item) => setItemExpanded(item, expanded: false);

  void _expand(TreeItem<TreeKeyType, TreeValueType> item) {
    if (!item.needsToLoadChildren) {
      setItemExpanded(item, expanded: true);
    }
  }

  void expandMatchingNodes(NodeMatchCondition<TreeNode<TreeKeyType, TreeValueType>> matchCondition,
      {bool shouldRebuild = true}) {
    visitNodes(
      matchCondition: (TreeNode<TreeKeyType, TreeValueType> node) {
        //TODO(bogdan): Check if hasChildren would be a better condition
        return node.item.hasChildren && (!node.item.needsToLoadChildren);
      },
      onVisit: (TreeNode<TreeKeyType, TreeValueType> node) {
        if (matchCondition(node)) {
          TreeNode<TreeKeyType, TreeValueType>? currentNode = node;
          while (currentNode != null) {
            setItemExpanded(currentNode.item, expanded: true);
            currentNode = currentNode.parent;
          }
        }
      },
    );
    if (shouldRebuild) {
      rebuild(animate: false);
    }
  }

  void expand(TreeItem<TreeKeyType, TreeValueType> item) {
    if (isItemExpanded(item)) {
      return;
    }
    _expand(item);
    rebuild();
  }

  void expandItems(Iterable<TreeItem<TreeKeyType, TreeValueType>> items) {
    bool shouldRebuild = false;
    for (final element in items) {
      if (!isItemExpanded(element)) {
        shouldRebuild = true;
        _expand(element);
      }
    }
    if (shouldRebuild) {
      rebuild(animate: false);
    }
  }

  void collapse(TreeItem<TreeKeyType, TreeValueType> item) {
    if (!isItemExpanded(item)) {
      return;
    }
    _collapse(item);
    rebuild();
  }

  void _applyCascadingAction(Iterable<TreeItem<TreeKeyType, TreeValueType>> items,
      Visitor<TreeItem<TreeKeyType, TreeValueType>> action) {
    for (final TreeItem<TreeKeyType, TreeValueType> item in items) {
      action(item);
      _applyCascadingAction(item.children, action);
    }
  }

  void expandCascading(Iterable<TreeItem<TreeKeyType, TreeValueType>> items) {
    if (items.isEmpty) {
      return;
    }
    _applyCascadingAction(items, _expand);
    rebuild();
  }

  void collapseCascading(Iterable<TreeItem<TreeKeyType, TreeValueType>> items) {
    if (items.isEmpty) {
      return;
    }
    _applyCascadingAction(items, _collapse);
    rebuild();
  }

  void expandAll() => expandCascading(items.rootItems);

  void collapseAll() => collapseCascading(items.rootItems);

  bool isNodeExpandedCondition(TreeNode<TreeKeyType, TreeValueType> node) => isItemExpanded(node.item);

  /// Visit nodes matching a specific condition.
  ///
  /// Visits nodes that are expanded if no condition is specified.
  void visitNodes({
    required Visitor<TreeNode<TreeKeyType, TreeValueType>> onVisit,
    NodeMatchCondition<TreeNode<TreeKeyType, TreeValueType>>? matchCondition,
    TreeNode<TreeKeyType, TreeValueType>? startingNode,
  }) {
    final NodeMatchCondition<TreeNode<TreeKeyType, TreeValueType>> visitChildren =
        matchCondition ?? isNodeExpandedCondition;

    void createTreeNodesForItems({
      required TreeNode<TreeKeyType, TreeValueType>? parent,
      required Iterable<TreeItem<TreeKeyType, TreeValueType>> items,
      required int level,
    }) {
      TreeNode<TreeKeyType, TreeValueType>? node;

      for (final item in items) {
        final bool itemHasChildren = item.hasChildren;
        final bool needsToLoadChildren = item.needsToLoadChildren;
        node = TreeNode<TreeKeyType, TreeValueType>(
          parent: parent,
          item: item,
          level: level,
        );

        onVisit(node);

        if (itemHasChildren && (needsToLoadChildren == false) && visitChildren(node)) {
          final children = item.children;
          createTreeNodesForItems(
            parent: node,
            items: children,
            level: level + 1,
          );
        }
      }
    }

    if (startingNode != null) {
      createTreeNodesForItems(
        parent: startingNode,
        items: startingNode.item.children,
        level: startingNode.level + 1,
      );
    } else {
      createTreeNodesForItems(
        parent: null,
        items: items.rootItems,
        level: treeRootLevel,
      );
    }
  }

  @override
  void dispose() {
    clearExpandedItems();
    onFilterUpdate.dispose();
    super.dispose();
  }
}

/// Every data object we want to display in a tree must have a TreeNode
/// that points to its parent node and level
class TreeNode<TreeKeyType, TreeValueType extends Object> {
  TreeNode({
    required this.parent,
    required this.item,
    required this.level,
  });

  final TreeNode<TreeKeyType, TreeValueType>? parent;
  final TreeItem<TreeKeyType, TreeValueType> item;
  final int level;
}
