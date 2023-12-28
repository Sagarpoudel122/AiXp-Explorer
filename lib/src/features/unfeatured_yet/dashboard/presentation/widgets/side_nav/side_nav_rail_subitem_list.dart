import 'package:e2_explorer/src/design/colors.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_sub_item_tile.dart';
import 'package:flutter/material.dart';

class SideNavRailSubItemList extends StatelessWidget {
  const SideNavRailSubItemList({super.key, this.item});

  final HomeNavigationItem? item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HFColors.dark800,
      elevation: 4,
      shape: Border(
        right: BorderSide(color: HFColors.dark700),
      ),
      child: SizedBox(
        width: 180,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOutCirc,
          switchOutCurve: Curves.easeInCirc,
          layoutBuilder:
              (Widget? currentChild, List<Widget> previousChildren) =>
                  currentChild ?? Container(),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-.25, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: SizedBox(
            key: ValueKey<HomeNavigationItem?>(item),
            height: double.infinity,
            child: ListView(
              physics: const ScrollPhysics(),
              children: <Widget>[
                if (item != null) ...<Widget>[
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HFColors.dark700,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: DefaultTextStyle(
                            // style: HFTextStyles.h4Bold()
                            //     .copyWith(color: HFColors.light900),
                            style: TextStyle(
                              color: HFColors.light900,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            child: Builder(
                              builder: item!.label,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconTheme(
                          data: IconThemeData(
                            color: HFColors.dark700,
                            size: 42,
                          ),
                          child: Builder(
                            builder: item!.icon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                for (final HomeNavigationSubItem subItem in (item?.subItems ?? []))
                  SideNavSubItemTile(
                    key: ValueKey<HomeNavigationSubItem>(subItem),
                    subItem: subItem,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
