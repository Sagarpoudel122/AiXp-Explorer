import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_tile.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class SideNavItemList extends StatelessWidget {
  const SideNavItemList({super.key, required this.items});

  final List<HomeNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          for (final HomeNavigationItem item in items)
            Column(
              children: <Widget>[
                SideNavItemTile(
                  key: ValueKey<HomeNavigationItem>(item),
                  item: item,
                ),
                if (item.enableLowerDivider)
                  Divider(color: AppColors.sideNavDividerColor),
              ],
            ),
        ],
      ),
    );
  }
}
