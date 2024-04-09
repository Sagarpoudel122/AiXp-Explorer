part of hf_tree;

typedef TreeItemFilter<TreeKeyType, TreeValueType> = bool Function(MapEntry<TreeKeyType, TreeValueType> data);
typedef TreeVisitor<TreeKeyType, TreeValueType> = void Function(TreeItem<TreeKeyType, TreeValueType> item);

class TreeData<TreeKeyType, TreeValueType> {
  final Map<TreeKeyType, TreeKeyType> parent = {};
  final Map<TreeKeyType, List<TreeKeyType>> childrenKeys = {};
  final List<TreeKeyType> roots = [];
}

class TreeItems<TreeKeyType, TreeValueType> {
  final Map<TreeKeyType, TreeValueType> _values = {};
  final Set<TreeKeyType> _hasChildren = {};
  final TreeData<TreeKeyType, TreeValueType> _data = TreeData();
  TreeData<TreeKeyType, TreeValueType>? _filteredData;
  Iterable<MapEntry<TreeKeyType, TreeValueType>> _filterMatches = {};
  TreeItemFilter<TreeKeyType, TreeValueType>? _filterCondition;
  bool _filterIncludeResultsChildren = true;
  TreeItems();

  bool get isFiltered => _filterCondition != null;

  TreeItem<TreeKeyType, TreeValueType> add(TreeKeyType key, TreeValueType value) {
    _values[key] = value;
    _data.roots.add(key);

    return _TreeItem(
      key: key,
      value: value,
      treeItems: this,
    );
  }

  Future<void> loadChildren({required TreeItem<TreeKeyType, TreeValueType> item}) {
    throw UnimplementedError();
  }

  void clearChildren({required TreeItem<TreeKeyType, TreeValueType> item}) {
    if (!_data.childrenKeys.containsKey(item.key)) {
      return;
    }
    _data.childrenKeys[item.key]!.clear();
    _data.childrenKeys.remove(item.key);
  }

  bool hasChildren({required TreeItem<TreeKeyType, TreeValueType> item}) {
    return _hasChildren.contains(item.key);
  }

  void setItemHasChildren({required TreeItem<TreeKeyType, TreeValueType> item, required bool value}) {
    if (value) {
      _hasChildren.add(item.key);
    } else {
      _hasChildren.remove(item.key);
    }
  }

  bool itemNeedsToLoadChildren({required TreeItem<TreeKeyType, TreeValueType> item}) {
    return false;
  }

  String getItemCaption({required TreeItem<TreeKeyType, TreeValueType> item}) {
    if (!_values.containsKey(item.key)) {
      return 'Invalid item';
    }
    return _values[item.key].toString();
  }

  bool delete({required TreeKeyType key, bool reapplyFilter = true}) {
    if (!_values.containsKey(key)) {
      return false;
    }
    if (!_removeChildKeyFromParent(data: _data, childKey: key)) {
      return false;
    }
    _values.remove(key);
    if (isFiltered && reapplyFilter) {
      applyFilter();
    }
    return true;
  }

  TreeItem<TreeKeyType, TreeValueType> addChild({
    required TreeKeyType parentKey,
    required TreeKeyType childKey,
    required TreeValueType childValue,
  }) {
    assert(_values.keys.contains(parentKey), 'Could not find parent to add child');
    // Add child value
    _values[childKey] = childValue;

    // Add child to parent
    _addChildKeyToParent(data: _data, parentKey: parentKey, childKey: childKey);

    // See if child matches filter
    if (_filterCondition != null &&
        _filterCondition!(MapEntry(
          childKey,
          childValue,
        ))) {
      addKeyToFilteredData(
        key: childKey,
        filteredData: _filteredData!,
        includeChildren: false,
      );
    }

    return _TreeItem(
      key: childKey,
      value: childValue,
      treeItems: this,
    );
  }

  void _addChildrenToFilteredData({
    required TreeKeyType key,
    required TreeData filteredData,
    required TreeData originalData,
  }) {
    if (!_data.childrenKeys.containsKey(key)) {
      return;
    }
    filteredData.childrenKeys[key] = originalData.childrenKeys[key]!;
    for (final childKey in _data.childrenKeys[key]!) {
      _addChildrenToFilteredData(
        key: childKey,
        filteredData: filteredData,
        originalData: originalData,
      );
    }
  }

  void _addChildKeyToParent({
    required TreeData data,
    required TreeKeyType parentKey,
    required TreeKeyType childKey,
  }) {
    // Create children list if not already present
    if (!data.childrenKeys.containsKey(parentKey)) {
      data.childrenKeys[parentKey] = <TreeKeyType>[];
    }
    // Add new child to children list
    data.childrenKeys[parentKey]!.add(childKey);

    // Set the parent for the new child
    data.parent[childKey] = parentKey;
  }

  void addKeyToFilteredData({
    required TreeKeyType key,
    required TreeData filteredData,
    required bool includeChildren,
  }) {
    var currentChild = key;
    var currentParent = _data.parent[currentChild];
    while (currentParent != null) {
      _addChildKeyToParent(
        data: filteredData,
        parentKey: currentParent,
        childKey: currentChild,
      );
      currentChild = currentParent;
      currentParent = _data.parent[currentChild];
    }
    filteredData.roots.add(currentChild);
    // Save children in filteredData if included
    if (includeChildren) {
      _addChildrenToFilteredData(key: key, originalData: _data, filteredData: filteredData);
    }
  }

  void filter({
    required TreeItemFilter<TreeKeyType, TreeValueType> condition,
    bool includeResultsChildren = true,
  }) {
    _filterIncludeResultsChildren = includeResultsChildren;
    _filterCondition = condition;
    final matches = _values.entries.where((element) => _filterCondition!(element));
    debugPrint('Matched items: $matches');
    TreeData<TreeKeyType, TreeValueType> filteredData = TreeData<TreeKeyType, TreeValueType>();
    for (final match in matches) {
      addKeyToFilteredData(
        key: match.key,
        filteredData: filteredData,
        includeChildren: includeResultsChildren,
      );
    }
    _filteredData = filteredData;
    _filterMatches = matches;
  }

  void applyFilter() {
    if (_filterCondition == null) {
      return;
    }
    filter(
      condition: _filterCondition!,
      includeResultsChildren: _filterIncludeResultsChildren,
    );
  }

  void clearFilter() {
    _filterCondition = null;
    _filteredData = null;
    _filterMatches = {};
  }

  Iterable<MapEntry<TreeKeyType, TreeValueType>> get filterMatches => _filterMatches;

  TreeItem<TreeKeyType, TreeValueType>? getItemByKey(TreeKeyType itemKey) {
    if (!_values.keys.contains(itemKey)) {
      return null;
    }
    return _TreeItem(
      key: itemKey,
      value: _values[itemKey] as TreeValueType,
      treeItems: this,
    );
  }

  Iterable<TreeItem<TreeKeyType, TreeValueType>> getChildren({required TreeKeyType parentKey}) {
    final data = _filterCondition != null ? _filteredData! : _data;

    if (!data.childrenKeys.keys.contains(parentKey)) {
      return [];
    }
    return data.childrenKeys[parentKey]!.map(
      (childKey) => _TreeItem(
        key: childKey,
        value: _values[childKey] as TreeValueType,
        treeItems: this,
      ),
    );
  }

  TreeItem<TreeKeyType, TreeValueType>? getParent({required TreeKeyType childKey}) {
    final data = _filterCondition != null ? _filteredData! : _data;

    if (!_values.containsKey(childKey)) {
      return null;
    }
    if (!data.parent.containsKey(childKey)) {
      return null;
    }

    final parentKey = data.parent[childKey] as TreeKeyType;
    final parentValue = _values[parentKey] as TreeValueType;

    return _TreeItem<TreeKeyType, TreeValueType>(
      key: parentKey,
      value: parentValue,
      treeItems: this,
    );
  }

  bool _removeChildKeyFromParent({
    required TreeData data,
    required childKey,
  }) {
    bool hasExistingParent = data.parent.containsKey(childKey);
    if (hasExistingParent) {
      // Remove from the current parent children list
      final currentParentID = data.parent[childKey];
      data.childrenKeys[currentParentID]!.removeWhere((element) => element == childKey);
      return true;
    }

    bool isRoot = data.roots.contains(childKey);
    if (isRoot) {
      // It doesn't have a parent so it must be part of the _rootItems
      // Remove it from the root items list
      data.roots.removeWhere((element) => element == childKey);
      return true;
    }

    return false;
  }

  bool setParent({
    required TreeKeyType newParentKey,
    required TreeKeyType childKey,
  }) {
    if (_values[childKey] == null) {
      // Could not find child
      return false;
    }

    if (_values[newParentKey] == null) {
      // Could not find new parent
      return false;
    }

    if (!_removeChildKeyFromParent(data: _data, childKey: childKey)) {
      return false;
    }

    // Add the item to the new parent's list of children
    _addChildKeyToParent(data: _data, parentKey: newParentKey, childKey: childKey);
    return true;
  }

  Iterable<TreeItem<TreeKeyType, TreeValueType>> get rootItems {
    final data = _filterCondition != null ? _filteredData! : _data;

    return data.roots.map((TreeKeyType rootItemKey) {
      return _TreeItem(
        key: rootItemKey,
        value: _values[rootItemKey] as TreeValueType,
        treeItems: this,
      );
    });
  }

  void printTreeItem({
    int depth = 0,
    required TreeKeyType itemID,
    required TreeData data,
  }) {
    // Print the root node with proper indentation
    String prefix = '  ' * depth;
    debugPrint('$prefix- $itemID - ${_values[itemID]}');

    if (!data.childrenKeys.containsKey(itemID)) {
      return;
    }

    final childrenIDs = data.childrenKeys[itemID]!;

    for (var childID in childrenIDs) {
      printTreeItem(itemID: childID, depth: depth + 1, data: data);
    }

    data.childrenKeys[itemID]!.map((currentChildID) {});
  }

  void printTree() {
    final data = _filterCondition != null ? _filteredData! : _data;
    if (data.roots.isEmpty) {
      debugPrint('Empty tree');
      return;
    }
    for (var id in data.roots) {
      printTreeItem(itemID: id, data: data);
    }
  }

  void visitChildrenWithAction({
    required TreeItem<TreeKeyType, TreeValueType> startingItem,
    Visitor<TreeItem<TreeKeyType, TreeValueType>>? actionBeforeVisit,
    Visitor<TreeItem<TreeKeyType, TreeValueType>>? actionAfterVisit,
  }) {
    assert(
      actionBeforeVisit != null || actionAfterVisit != null,
      'Please provide at least one action: before or after',
    );
    final children = startingItem.children;
    for (final child in children) {
      actionBeforeVisit?.call(child);
      visitChildrenWithAction(
        startingItem: child,
        actionBeforeVisit: actionBeforeVisit,
        actionAfterVisit: actionAfterVisit,
      );
      actionAfterVisit?.call(child);
    }
  }
}
