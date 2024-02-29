part of hf_tree;

class TreeSelectionChanged<TreeItemType extends Object> {
  TreeSelectionChanged({
    required this.item,
  });
  TreeItemType item;
}

typedef TreeSelectionChangedSub<TreeItemType extends Object> = StreamSubscription<TreeItemType>;

class TreeItemCheckChanged<TreeItemType extends Object> {
  TreeItemCheckChanged({
    required this.item,
    required this.checked,
  });
  TreeItemType item;
  bool checked;
}

typedef TreeItemCheckChangedSub<TreeValueType extends Object> = StreamSubscription<TreeItemCheckChanged<TreeValueType>>;
