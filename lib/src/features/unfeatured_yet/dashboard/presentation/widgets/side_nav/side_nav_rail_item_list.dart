

import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_rail_item_tile.dart';
import 'package:flutter/material.dart';

/// Widget that displays all navigation items in collapsed list format.
class SideNavRailItemList extends StatelessWidget {
  const SideNavRailItemList({super.key, required this.items});


  final List<HomeNavigationItem> items;

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            for (final HomeNavigationItem item in items)
              SideNavItemRailTile(
                key: ValueKey<HomeNavigationItem>(item),
                item: item,
              ),
          ],
        ),
      ),
    );
  }
}
