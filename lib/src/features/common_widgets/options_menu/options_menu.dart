import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_offset/flutter_widget_offset.dart';

part 'options_menu_button.dart';
part 'options_menu_items.dart';

class OptionsMenu extends StatelessWidget {
  const OptionsMenu({
    super.key,
    required this.items,
    this.onItemTap,
    this.fillColor = ColorStyles.dark700,
    this.borderColor = ColorStyles.dark600,
  });

  final List<BaseMenuItem> items;
  final Color fillColor;
  final Color borderColor;
  final void Function(BaseMenuItem item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      child: Material(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        color: fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: ColorStyles.dark600),
        ),
        child: IntrinsicWidth(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (final BaseMenuItem item in items) _buildItem(item),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BaseMenuItem item) {
    if (item is MenuOptionItem) {
      return _buildOptionItem(item);
    }
    if (item is MenuOptionBuilderItem) {
      return _buildOptionBuilderItem(item);
    }
    if (item is MenuHeaderItem) {
      return _buildHeaderItem(item);
    }
    if (item is MenuDividerItem) {
      return _buildDividerItem(item);
    }
    if (item is MenuWhitespaceItem) {
      return _buildWhitespaceItem(item);
    }
    if (item is MenuWidgetItem) {
      return _buildWidgetItem(item);
    }
    return const SizedBox.shrink();
  }

  Widget _buildOptionItem(MenuOptionItem item) {
    return InkWell(
      onTap: () {
        item.onTap();
        onItemTap?.call(item);
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: item.color,
            size: 16,
          ),
          child: DefaultTextStyle(
            style: TextStyles.small(
              color: item.color,
            ),
            overflow: TextOverflow.ellipsis,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (item.leading != null) ...<Widget>[
                  item.leading!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: item.child,
                ),
                if (item.trailing != null) ...<Widget>[
                  const SizedBox(width: 8),
                  item.trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionBuilderItem(MenuOptionBuilderItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Builder(
          builder: (BuildContext context) => item.builder(context, item.child),
        ),
      ),
    );
  }

  Widget _buildHeaderItem(MenuHeaderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8) +
          (item != items.first ? EdgeInsets.zero : EdgeInsets.zero),
      child: Text(
        item.text,
        style: TextStyles.small(
          color: ColorStyles.light900,
        ),
      ),
    );
  }

  Widget _buildDividerItem(MenuDividerItem item) {
    return Divider(
      color: borderColor,
      height: 8,
      thickness: 1,
    );
  }

  Widget _buildWhitespaceItem(MenuWhitespaceItem item) {
    return SizedBox(
      height: item.height,
    );
  }

  Widget _buildWidgetItem(MenuWidgetItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: item.child,
    );
  }
}
