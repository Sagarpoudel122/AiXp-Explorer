part of hf_tree;

typedef TreeTransitionBuilder = Widget Function(
  BuildContext context,
  Widget child,
  Animation<double> animation,
);

Widget defaultTreeTransitionBuilder(
  BuildContext context,
  Widget child,
  Animation<double> animation,
) {
  return SizeTransition(sizeFactor: animation, child: child);
}

Widget fadeSizeTransitionBuilder(
    BuildContext context, Widget child, Animation<double> animation) {
  return FadeTransition(
    opacity: animation,
    child: SizeTransition(
      sizeFactor: animation,
      child: child,
    ),
  );
}

class SliverListTreeAnimated<TreeKeyType, TreeValueType extends Object>
    extends SliverTree<TreeKeyType, TreeValueType> {
  const SliverListTreeAnimated({
    super.key,
    required super.controller,
    required super.nodeBuilder,
    required super.emptyStateBuilder,
    this.transitionBuilder = defaultTreeTransitionBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut, // Curves.linear
    this.onItemCheckedChange,
  });

  final TreeTransitionBuilder transitionBuilder;
  final Duration duration;
  final Curve curve;
  final TreeItemCheckedCallback<TreeKeyType, TreeValueType>?
      onItemCheckedChange;

  @override
  State<SliverListTreeAnimated<TreeKeyType, TreeValueType>> createState() =>
      _SliverListTreeAnimated<TreeKeyType, TreeValueType>();
}

class _SliverListTreeAnimated<TreeKeyType, TreeValueType extends Object>
    extends State<SliverListTreeAnimated<TreeKeyType, TreeValueType>> {
  Map<TreeKeyType, bool> _expansionStatesMap = <TreeKeyType, bool>{};

  // A list containing all the expanded items and their children
  List<TreeNode<TreeKeyType, TreeValueType>> _displayedNodesList =
      <TreeNode<TreeKeyType, TreeValueType>>[];

  void _onFilterUpdate() {
    // Clear expansion states cache
    _expansionStatesMap.clear();
  }

  void _updateDisplayedNodesList() {
    final Map<TreeKeyType, bool> oldExpandedStateMap =
        Map<TreeKeyType, bool>.of(_expansionStatesMap);

    final Map<TreeKeyType, bool> currentExpandedStateMap =
        <TreeKeyType, bool>{};
    final List<TreeNode<TreeKeyType, TreeValueType>> displayedNodesList =
        <TreeNode<TreeKeyType, TreeValueType>>[];

    final Visitor<TreeNode<TreeKeyType, TreeValueType>> onVisit;

    if (widget.duration == Duration.zero) {
      onVisit = (TreeNode<TreeKeyType, TreeValueType> node) {
        displayedNodesList.add(node);
        currentExpandedStateMap[node.item.key] =
            widget.controller.isItemExpanded(node.item);
      };
    } else {
      onVisit = (TreeNode<TreeKeyType, TreeValueType> node) {
        displayedNodesList.add(node);
        currentExpandedStateMap[node.item.key] =
            widget.controller.isItemExpanded(node.item);

        if (widget.controller.animateExpandCollapse == false) {
          return;
        }

        final bool? previousState = oldExpandedStateMap[node.item.key];
        if ((previousState != null) &&
            (previousState != widget.controller.isItemExpanded(node.item))) {
          _animatingItems.add(node.item.key);
        }
      };
    }

    widget.controller.visitNodes(
      onVisit: onVisit,
      matchCondition: (TreeNode<TreeKeyType, TreeValueType> node) {
        if (_animatingItems.contains(node.item.key)) {
          // Don't include animating (expanding/collapsing) items in the displayed nodes list
          return false;
        }
        return widget.controller.isItemExpanded(node.item);
      },
    );

    _displayedNodesList = displayedNodesList;
    _expansionStatesMap = currentExpandedStateMap;
  }

  void _rebuild() => setState(_updateDisplayedNodesList);

  final Set<TreeKeyType> _animatingItems = <TreeKeyType>{};

  void _onAnimationComplete(TreeKeyType item) {
    _animatingItems.remove(item);
    _rebuild();
  }

  List<TreeNode<TreeKeyType, TreeValueType>> _buildSubtree(
      TreeNode<TreeKeyType, TreeValueType> node) {
    final List<TreeNode<TreeKeyType, TreeValueType>> displayedNodesSubtree =
        <TreeNode<TreeKeyType, TreeValueType>>[];
    widget.controller.visitNodes(
      startingNode: node,
      onVisit: displayedNodesSubtree.add,
    );
    return displayedNodesSubtree;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
    widget.controller.onFilterUpdate.addListener(_onFilterUpdate);
    _updateDisplayedNodesList();
  }

  @override
  void didUpdateWidget(
      covariant SliverListTreeAnimated<TreeKeyType, TreeValueType> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      oldWidget.controller.onFilterUpdate.removeListener(_onFilterUpdate);
      widget.controller.addListener(_rebuild);
      widget.controller.onFilterUpdate.addListener(_onFilterUpdate);
      _updateDisplayedNodesList();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    _animatingItems.clear();
    _displayedNodesList = <TreeNode<TreeKeyType, TreeValueType>>[];
    _expansionStatesMap.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_displayedNodesList.isEmpty) {
      return SliverToBoxAdapter(child: widget.emptyStateBuilder(context));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: _displayedNodesList.length,
        (BuildContext context, int index) {
          final TreeNode<TreeKeyType, TreeValueType> node =
              _displayedNodesList[index];
          return _TreeNodeWidget<TreeKeyType, TreeValueType>(
            key: _TreeNodeKey(node.item.value),
            node: node,
            controller: widget.controller,
            headerBuilder: widget.nodeBuilder,
            contentBuilder: _buildSubtree,
            transitionBuilder: widget.transitionBuilder,
            onAnimationComplete: _onAnimationComplete,
            curve: widget.curve,
            duration: widget.duration,
            showSubtree: _animatingItems.contains(node.item.key),
          );
        },
      ),
    );
  }
}

class _TreeNodeKey extends GlobalObjectKey {
  const _TreeNodeKey(super.value);
}

typedef _TreeNodeContentBuilder<TreeKeyType, TreeValueType extends Object>
    = List<TreeNode<TreeKeyType, TreeValueType>> Function(
  TreeNode<TreeKeyType, TreeValueType> virtualRoot,
);

class _TreeNodeWidget<TreeKeyType, TreeValueType extends Object>
    extends StatefulWidget {
  const _TreeNodeWidget({
    super.key,
    required this.node,
    required this.headerBuilder,
    required this.contentBuilder,
    required this.transitionBuilder,
    required this.onAnimationComplete,
    required this.curve,
    required this.duration,
    required this.showSubtree,
    required this.controller,
  });

  final TreeNode<TreeKeyType, TreeValueType> node;
  final TreeController<TreeKeyType, TreeValueType> controller;
  final TreeNodeHeaderBuilder<TreeKeyType, TreeValueType> headerBuilder;
  final _TreeNodeContentBuilder<TreeKeyType, TreeValueType> contentBuilder;

  final TreeTransitionBuilder transitionBuilder;
  final ValueSetter<TreeKeyType> onAnimationComplete;
  final Curve curve;
  final Duration duration;
  final bool showSubtree;

  @override
  State<_TreeNodeWidget<TreeKeyType, TreeValueType>> createState() =>
      _TreeNodeWidgetState<TreeKeyType, TreeValueType>();
}

class _TreeNodeWidgetState<TreeKeyType, TreeValueType extends Object>
    extends State<_TreeNodeWidget<TreeKeyType, TreeValueType>>
    with SingleTickerProviderStateMixin {
  //TreeNode<TreeKeyType,TreeValueType> get item => widget.node;
  //TreeValueType get nodeData => item.data;

  late final AnimationController animationController;
  late final CurveTween curveTween;

  bool _isExpandedInternal = false;

  void onAnimationComplete() {
    widget.onAnimationComplete(widget.node.item.key);
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void expand() {
    final double? from = animationController.value == 1.0 ? 0.0 : null;
    animationController.forward(from: from).whenComplete(onAnimationComplete);
  }

  void collapse() {
    final double? from = animationController.value == 0.0 ? 1.0 : null;
    animationController.reverse(from: from).whenComplete(onAnimationComplete);
  }

  @override
  void initState() {
    super.initState();
    _isExpandedInternal = widget.controller.isItemExpanded(widget.node.item);

    curveTween = CurveTween(curve: widget.curve);
    animationController = AnimationController(
      vsync: this,
      value: _isExpandedInternal ? 1.0 : 0.0,
      duration: widget.duration,
    );
  }

  @override
  void didUpdateWidget(
      covariant _TreeNodeWidget<TreeKeyType, TreeValueType> oldWidget) {
    super.didUpdateWidget(oldWidget);

    curveTween.curve = widget.curve;
    animationController.duration = widget.duration;

    final bool expansionState =
        widget.controller.isItemExpanded(widget.node.item);

    if (_isExpandedInternal != expansionState) {
      _isExpandedInternal = expansionState;

      if (widget.showSubtree) {
        _isExpandedInternal ? expand() : collapse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = widget.headerBuilder(context, widget.node);

    late final Widget content = _TreeNodeContent<TreeKeyType, TreeValueType>(
      virtualRoot: widget.node,
      headerBuilder: widget.headerBuilder,
      contentBuilder: widget.contentBuilder,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        header,
        if (widget.showSubtree && animationController.isAnimating)
          widget.transitionBuilder(
            context,
            content,
            animationController.drive(curveTween),
          ),
      ],
    );
  }
}

class _TreeNodeContent<TreeKeyType, TreeValueType extends Object>
    extends StatefulWidget {
  const _TreeNodeContent({
    super.key,
    required this.virtualRoot,
    required this.headerBuilder,
    required this.contentBuilder,
  });

  final TreeNode<TreeKeyType, TreeValueType> virtualRoot;
  final TreeNodeHeaderBuilder<TreeKeyType, TreeValueType> headerBuilder;
  final _TreeNodeContentBuilder<TreeKeyType, TreeValueType> contentBuilder;

  @override
  State<_TreeNodeContent<TreeKeyType, TreeValueType>> createState() =>
      _TreeNodeContentState<TreeKeyType, TreeValueType>();
}

class _TreeNodeContentState<TreeKeyType, TreeValueType extends Object>
    extends State<_TreeNodeContent<TreeKeyType, TreeValueType>> {
  late List<TreeNode<TreeKeyType, TreeValueType>> virtualItems;

  @override
  void initState() {
    super.initState();
    virtualItems = widget.contentBuilder(widget.virtualRoot);
  }

  @override
  void dispose() {
    virtualItems = <TreeNode<TreeKeyType, TreeValueType>>[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final TreeNode<TreeKeyType, TreeValueType> virtualItem
              in virtualItems)
            widget.headerBuilder(context, virtualItem),
        ],
      ),
    );
  }
}
