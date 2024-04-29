part of ai;

class AITreeItemWidget extends StatefulWidget {
  const AITreeItemWidget({
    super.key,
    required this.node,
    required this.controller,
    this.menuItems = const <BaseMenuItem>[],
    this.showMenu = false,
    this.showCheckbox = false,
    this.canBeSelected = false,
    this.buttonsBuilder,
    required this.iconData,
  });

  final IconData iconData;
  final bool showMenu;
  final bool showCheckbox;
  final bool canBeSelected;
  final TreeNode<String, AITreeValue<dynamic>> node;
  final TreeController<String, AITreeValue<dynamic>> controller;
  final List<BaseMenuItem> menuItems;
  final List<Widget> Function(AITreeItem item)? buttonsBuilder;

  @override
  State<AITreeItemWidget> createState() => _AITreeItemWidgetState();
}

class _AITreeItemWidgetState extends State<AITreeItemWidget> {
  bool _isHovered = false;
  bool _isMenuOpen = false;

  List<Widget> _buildButtonsAndMenu(AITreeItem item) {
    final List<Widget>? itemButtons = widget.buttonsBuilder?.call(item);
    return <Widget>[
      if (widget.showMenu)
        SizedBox(
          width: 24,
          height: 24,
          child: OptionsMenuButton(
            materialColor: AppColors.dropdownFieldFillColor,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            onOpenOptionBox: () {
              setState(() {
                _isMenuOpen = true;
              });
            },
            onCloseOptionBox: () {
              setState(() {
                _isMenuOpen = false;
              });
            },
            items: widget.menuItems,
          ),
        ),
      if (itemButtons != null && itemButtons.isNotEmpty)
        const SizedBox(width: 5),
      if (itemButtons != null && itemButtons.isNotEmpty) ...itemButtons,
    ];
  }

  @override
  void didUpdateWidget(covariant AITreeItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final AITreeNode node = widget.node;
    final bool hasChildren = node.item.hasChildren;

    const double iconSize = 20;
    const double iconContainerWidth = 18;
    const double iconContainerHeight = 18;
    const double levelSize = 10;
    final bool isLoading = widget.controller.isItemLoading(node.item);
    Color backgroundColor = (_isHovered || _isMenuOpen)
        ? AppColors.dropdownFieldFillColor
        : Colors.transparent;
    if (widget.controller.isItemSelected(node.item)) {
      backgroundColor =AppColors.dropdownFieldFillColor.withOpacity(0.8);
      // backgroundColor = const Color.fromARGB(255, 45, 45, 44);
    }

    return InkWell(
      hoverColor: AppColors.dropdownFieldFillColor,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      onHover: (bool isHovered) {
        setState(() {
          _isHovered = isHovered;
        });
      },
      onTap: () {
        if (widget.canBeSelected) {
          widget.controller.selectItem(node.item);
        } else {
          if (!widget.showCheckbox && hasChildren) {
            widget.controller.toggleItemExpanded(node.item);
          }
        }
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                // color: Colors.red,
                color: backgroundColor,
              ),
            ),
          ),
          TreeItemPadded(
            firstLineLevel: 2,
            node: node,
            lineColor: node.level == 1
                ? Colors.transparent
                : const Color.fromARGB(123, 158, 158, 158),
            levelSize: levelSize,
            contentBuilder: () => Padding(
              padding: const EdgeInsets.all(4),
              child: TreeItemContent<AITreeValue<dynamic>, String,
                  AITreeController>(
                item: node.item,
                isLoading: isLoading,
                iconContainerWidth: iconContainerWidth,
                iconContainerHeight: iconContainerHeight,
                hasChildren: hasChildren,
                isExpanded: widget.controller.isItemExpanded(node.item),
                icon: Icon(
                  widget.iconData,
                  size: iconSize,
                  color: AppColors.textPrimaryColor,
                ),
                treeController: widget.controller,
                showCheckbox: widget.showCheckbox,
                canBeSelected: widget.canBeSelected,
                buttonsBuilder: _buildButtonsAndMenu,
                buttonsVisible: (AITreeItem item) {
                  return _isHovered || _isMenuOpen;
                },
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }
}
