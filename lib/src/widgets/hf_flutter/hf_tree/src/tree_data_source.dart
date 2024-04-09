part of hf_tree;

class TreeDataSource<TreeKeyType, TreeValueType> {
  TreeDataSource({required this.roots}) {
    treeMap = createTreeMap<TreeKeyType, TreeValueType>(
      roots: this.roots,
      getUuid: getUniqueID,
      getChildren: getChildren,
    );
  }

  final Iterable<TreeValueType> roots;

  late TreeMap<TreeKeyType, TreeValueType> treeMap;

  TreeValueType? getItemByID(TreeKeyType uuid) {
    return treeMap.items[uuid];
  }

  @mustBeOverridden
  String getText(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  void addChild(TreeValueType parent, TreeValueType child) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  void removeChildByID(TreeValueType parent, TreeKeyType childID) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  void sortChildren(TreeValueType parent) {
    throw UnimplementedError();
  }

  void deleteByID({
    required TreeKeyType itemID,
  }) {
    final TreeValueType? item = getItemByID(itemID);
    if (item == null) {
      debugPrint('Could not find item to delete');
      return;
    }
    final TreeValueType? parent = getParent(item);
    if (parent != null) {
      removeChildByID(parent, itemID);
    }
  }

  void changeByID({
    required TreeKeyType itemID,
    required TreeValueType Function(TreeValueType) changeFunction,
  }) {
    final TreeValueType? item = getItemByID(itemID);
    if (item == null) {
      debugPrint('Could not find item to change');
      return;
    }

    final changedItem = changeFunction(item);
    treeMap.items[itemID] = changedItem;

    final TreeValueType? parent = getParent(item);
    if (parent != null) {
      removeChildByID(parent, itemID);
      addChild(parent, changedItem);
    }
  }

  @mustBeOverridden
  Iterable<TreeValueType> getChildren(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  TreeValueType? getParent(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  TreeKeyType getUniqueID(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  bool hasChildren(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  bool needsToLoadChildren(TreeValueType item) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  Future<void> loadChildren(TreeValueType item) async {
    throw UnimplementedError();
  }

  void filter({
    required NodeMatchCondition<TreeValueType> condition,
    required FilterResultSetNewChildren<TreeValueType> setNewChildren,
    required FilterResultRemoveChildren<TreeValueType> removeChildren,
  }) {
    final List<TreeValueType> filteredTree = filterTree<TreeValueType>(
      roots: roots,
      condition: condition,
      getChildren: getChildren,
      setNewChildren: setNewChildren,
      removeChildren: removeChildren,
    );
    _filteredDataSource = TreeDataSource<TreeKeyType, TreeValueType>(roots: filteredTree);
  }

  bool get isFiltered => filteredData != null;

  /// Returns the filteredRoots if a filter is set
  /// or the tree roots otherwise
  Iterable<TreeValueType> get currentRoots => isFiltered ? filteredData!.roots : this.roots;

  TreeDataSource<TreeKeyType, TreeValueType>? get filteredData => _filteredDataSource;
  void clearFilter() {
    _filteredDataSource = null;
  }

  TreeDataSource<TreeKeyType, TreeValueType>? _filteredDataSource;

  void visitTreeWithAction({required TreeValueType startingNode, required Visitor<TreeValueType> action}) {
    action(startingNode);
    final Iterable<TreeValueType> children = getChildren(startingNode);
    for (final TreeValueType child in children) {
      visitTreeWithAction(startingNode: child, action: action);
    }
  }

  void visitChildrenWithAction({
    required TreeValueType startingNode,
    Visitor<TreeValueType>? actionBeforeVisit,
    Visitor<TreeValueType>? actionAfterVisit,
  }) {
    assert(
      actionBeforeVisit != null || actionAfterVisit != null,
      'Please provide at least one action: before or after',
    );
    final Iterable<TreeValueType> children = getChildren(startingNode);
    for (final TreeValueType child in children) {
      actionBeforeVisit?.call(child);
      visitChildrenWithAction(
        startingNode: child,
        actionBeforeVisit: actionBeforeVisit,
        actionAfterVisit: actionAfterVisit,
      );
      actionAfterVisit?.call(child);
    }
  }

  void visitParentsWithAction({required TreeValueType startingNode, required Visitor<TreeValueType> action}) {
    TreeValueType? currentParent = getParent(startingNode);
    while (currentParent != null) {
      action(currentParent);
      currentParent = getParent(currentParent);
    }
  }
}

class TreeMap<UuidType, ItemType> {
  TreeMap({required this.items, required this.parents});
  final Map<UuidType, ItemType> items;
  final Map<UuidType, ItemType?> parents;
}

TreeMap<UuidType, ItemType> createTreeMap<UuidType, ItemType>({
  required Iterable<ItemType> roots,
  required NodeGetUuid<UuidType, ItemType> getUuid,
  required NodeGetChildren<ItemType> getChildren,
}) {
  final Map<UuidType, ItemType> uuidMap = <UuidType, ItemType>{};
  final Map<UuidType, ItemType?> parentsMap = <UuidType, ItemType?>{};

  void traverseTree(ItemType node, ItemType? parent) {
    final UuidType uuid = getUuid(node);
    uuidMap[uuid] = node;
    if (parent != null) {
      parentsMap[uuid] = parent;
    }

    final Iterable<ItemType> nodeChildren = getChildren(node);
    if (nodeChildren.isNotEmpty) {
      for (final ItemType child in nodeChildren) {
        traverseTree(child, node);
      }
    }
  }

  for (final ItemType root in roots) {
    final UuidType currentRootUuid = getUuid(root);
    traverseTree(root, null);
    parentsMap[currentRootUuid] = null;
  }
  return TreeMap<UuidType, ItemType>(items: uuidMap, parents: parentsMap);
}
