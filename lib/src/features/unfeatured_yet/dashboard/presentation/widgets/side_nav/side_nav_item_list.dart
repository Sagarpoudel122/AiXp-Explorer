import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_tile.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class SideNavItemList extends StatelessWidget {
  const SideNavItemList(
      {super.key, required this.items, required this.selectedIndex});

  final List<HomeNavigationItem> items;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            Column(
              children: <Widget>[
                SideNavItemTile(
                  key: ValueKey<HomeNavigationItem>(items[i]),
                  item: items[i],
                  isSelected: selectedIndex == i,
                ),
                if (items[i].enableLowerDivider)
                  Divider(color: AppColors.sideNavDividerColor),
              ],
            ),
        ],
      ),
    );
  }
}
