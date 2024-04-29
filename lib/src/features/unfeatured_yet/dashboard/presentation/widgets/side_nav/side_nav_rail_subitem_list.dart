import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_sub_item_tile.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideNavRailSubItemList extends StatelessWidget {
  const SideNavRailSubItemList({super.key, this.item});

  final HomeNavigationItem? item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorStyles.dark800,
      elevation: 4,
      shape: const Border(
        right: BorderSide(color: ColorStyles.dark700),
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
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorStyles.dark700,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: DefaultTextStyle(
                            // style: HFTextStyles.h4Bold()
                            //     .copyWith(color: HFColors.light900),
                            style: const TextStyle(
                              color: ColorStyles.light900,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            child: Builder(
                              builder: item!.label,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (item!.svgIconPath != null) ...<Widget>[
                          Container(
                            width: 34,
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              item!.svgIconPath!,
                              color: AppColors.sideNavUnselectedTileIconColor,
                            ),
                          ),
                        ] else if (item!.iconData != null) ...<Widget>[
                          Container(
                            width: 34,
                            alignment: Alignment.centerLeft,
                            child: IconTheme(
                              data: IconThemeData(
                                color: AppColors.sideNavUnselectedTileIconColor,
                              ),
                              child: Icon(item!.iconData),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                for (final HomeNavigationSubItem subItem
                    in (item?.subItems ?? []))
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
