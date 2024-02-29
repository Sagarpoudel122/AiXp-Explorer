part of hf_tree;

abstract class TreeItem<TreeKeyType, TreeValueType> {
  final TreeKeyType key;
  final TreeValueType value;

  TreeItem({
    required this.key,
    required this.value,
  });

  @override
  String toString() => 'TreeItem(key: $key, data: $value)';

  TreeItem<TreeKeyType, TreeValueType>? get parent;
  TreeItem<TreeKeyType, TreeValueType>? getAncestorByCondition({required bool Function(TreeKeyType key) condition});
  Iterable<TreeItem<TreeKeyType, TreeValueType>> get children;

  bool get hasChildren;
  set hasChildren(bool value);
  String get caption;

  bool setParent(TreeItem<TreeKeyType, TreeValueType> item);
  bool setParentByKey(TreeKeyType parentKey);
  TreeItem<TreeKeyType, TreeValueType> addChild(TreeKeyType key, TreeValueType value);
  bool delete({bool reapplyFilter = true});
  bool get needsToLoadChildren;
  Future<void> loadChildren();

  /// Remove all children
  void clear();
}

class _TreeItem<TreeKeyType, TreeValueType> extends TreeItem<TreeKeyType, TreeValueType> {
  final TreeItems<TreeKeyType, TreeValueType> treeItems;
  _TreeItem({
    required super.key,
    required super.value,
    required this.treeItems,
  });

  @override
  TreeItem<TreeKeyType, TreeValueType>? get parent {
    return treeItems.getParent(childKey: super.key);
  }

  /// Returns ancestor item from tree where the key matches the condition set in the parameter [condition] function
  /// The item itself can be the searched ancesotr as well, if the item matches its condition
  @override
  TreeItem<TreeKeyType, TreeValueType>? getAncestorByCondition({required bool Function(TreeKeyType key) condition}) {
    if(condition.call(super.key)) {
      return this;
    }
    var item = treeItems.getParent(childKey: super.key);
    while(item != null && !condition.call(item.key)) {
      item = treeItems.getParent(childKey: item.key);
    }
    return item;
  }

  @override
  bool setParent(TreeItem parent) {
    return treeItems.setParent(newParentKey: parent.key, childKey: super.key);
  }

  @override
  bool setParentByKey(TreeKeyType parentKey) {
    return treeItems.setParent(newParentKey: parentKey, childKey: super.key);
  }

  @override
  Iterable<TreeItem<TreeKeyType, TreeValueType>> get children => treeItems.getChildren(parentKey: super.key);

  @override
  TreeItem<TreeKeyType, TreeValueType> addChild(TreeKeyType key, TreeValueType value) {
    return treeItems.addChild(parentKey: super.key, childKey: key, childValue: value);
  }

  @override
  bool delete({bool reapplyFilter = true}) {
    return treeItems.delete(
      key: super.key,
      reapplyFilter: reapplyFilter,
    );
  }

  @override
  bool get hasChildren => treeItems.hasChildren(item: this);

  @override
  set hasChildren(bool value) => treeItems.setItemHasChildren(
        item: this,
        value: value,
      );

  @override
  String get caption => treeItems.getItemCaption(item: this);

  @override
  bool get needsToLoadChildren => treeItems.itemNeedsToLoadChildren(item: this);

  @override
  Future<void> loadChildren() async {
    await treeItems.loadChildren(item: this);
  }

  @override
  void clear() {
    treeItems.clearChildren(item: this);
  }
}
