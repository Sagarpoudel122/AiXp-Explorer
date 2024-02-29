part of hf_tree;

typedef TreeNodeHeaderBuilder<TreeKeyType, TreeValueType extends Object> = Widget Function(
  BuildContext context,
  TreeNode<TreeKeyType, TreeValueType> node,
);

class SliverTree<TreeKeyType, TreeValueType extends Object> extends StatefulWidget {
  const SliverTree({
    super.key,
    required this.controller,
    required this.nodeBuilder,
    required this.emptyStateBuilder,
  });

  final TreeController<TreeKeyType, TreeValueType> controller;
  final TreeNodeHeaderBuilder<TreeKeyType, TreeValueType> nodeBuilder;
  final Widget Function(BuildContext context) emptyStateBuilder;

  @override
  State<SliverTree<TreeKeyType, TreeValueType>> createState() => _SliverTreeState<TreeKeyType, TreeValueType>();
}

class _SliverTreeState<TreeKeyType, TreeValueType extends Object>
    extends State<SliverTree<TreeKeyType, TreeValueType>> {
  /// A list containing all the expanded items and their children
  List<TreeNode<TreeKeyType, TreeValueType>> _displayedNodesList = <TreeNode<TreeKeyType, TreeValueType>>[];

  void _updateDisplayedNodesList() {
    final List<TreeNode<TreeKeyType, TreeValueType>> displayedNodesList = <TreeNode<TreeKeyType, TreeValueType>>[];
    widget.controller.visitNodes(onVisit: displayedNodesList.add);
    _displayedNodesList = displayedNodesList;
  }

  void _rebuild() => setState(_updateDisplayedNodesList);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
    _updateDisplayedNodesList();
  }

  @override
  void didUpdateWidget(covariant SliverTree<TreeKeyType, TreeValueType> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      widget.controller.addListener(_rebuild);
      _updateDisplayedNodesList();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    _displayedNodesList = <TreeNode<TreeKeyType, TreeValueType>>[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: _displayedNodesList.length,
        (BuildContext context, int index) {
          return widget.nodeBuilder(context, _displayedNodesList[index]);
        },
      ),
    );
  }
}
