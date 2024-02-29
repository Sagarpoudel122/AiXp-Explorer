part of hf_tree;

class TreeItemContent<TreeValueType extends Object, TreeKeyType,
        ControllerType extends TreeController<TreeKeyType, TreeValueType>>
    extends StatelessWidget {
  const TreeItemContent({
    super.key,
    required this.item,
    required this.iconContainerWidth,
    required this.iconContainerHeight,
    required this.hasChildren,
    required this.isExpanded,
    required ControllerType treeController,
    required this.isLoading,
    required this.showCheckbox,
    required this.canBeSelected,
    required this.icon,
    required this.buttonsVisible,
    this.checkChildren = true,
    this.buttonsBuilder,
  }) : _treeController = treeController;

  final double iconContainerWidth;
  final double iconContainerHeight;
  final bool hasChildren;
  final bool showCheckbox;
  final List<Widget> Function(TreeItem<TreeKeyType, TreeValueType>)?
      buttonsBuilder;
  final bool Function(TreeItem<TreeKeyType, TreeValueType>) buttonsVisible;

  /// Specifies whether checking a parent item should also check children
  final bool checkChildren;
  final bool canBeSelected;
  final bool isExpanded;
  final bool isLoading;
  final ControllerType _treeController;
  final TreeItem<TreeKeyType, TreeValueType> item;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final buttons = buttonsBuilder?.call(item);
    final areButtonsVisible = buttonsVisible.call(item);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ExpandCollapseIcon(
          expanded: isExpanded,
          hasChildren: hasChildren,
          onTap: () {
            _treeController.toggleItemExpanded(item);
          },
          isLoading: isLoading,
        ),
        SizedBox(
          width: iconContainerWidth,
          height: iconContainerHeight,
          child: Center(child: icon),
        ),
        const SizedBox(width: 4),
        if (showCheckbox)
          Checkbox(
            tristate: true,
            value: _treeController.getCheckboxValue(item),
            onChanged: (bool? newValue) {
              final bool? currentValue = _treeController.getCheckboxValue(item);
              // ignore: avoid_bool_literals_in_conditional_expressions
              final bool newValue = currentValue == null ? true : !currentValue;
              _treeController.setItemCheckboxValue(
                item,
                value: newValue,
                includeChildren: checkChildren,
              );
            },
          )
        else
          const SizedBox(height: 30),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (showCheckbox) {
                _treeController.toggleItemCheckbox(item);
              } else {
                if (canBeSelected) {
                  _treeController.selectItem(item);
                } else {
                  _treeController.toggleItemExpanded(item);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyles.small14regular(
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: areButtonsVisible,
          child: Row(
            children: (buttons != null)
                ? buttons
                : [
                    const SizedBox.shrink(),
                  ],
          ),
        ),
      ],
    );
  }
}
