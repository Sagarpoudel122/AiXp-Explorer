import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeftNavLayout extends StatefulWidget {
  const LeftNavLayout({
    super.key,
    this.pages = const [],
    required this.child,
  });

  final List<NavigationItem> pages;
  final Widget child;

  @override
  State<LeftNavLayout> createState() => _LeftNavLayoutState();
}

class _LeftNavLayoutState extends State<LeftNavLayout> {
  /// ToDO: initialize from future nav menu controller
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Dimens.sideNavWidth,
          child: SideNav(
            selectedIndex: _navIndex,
            isExpanded: false,
            items: widget.pages.map(
              (e) {
                if (e.children != null) {
                  return HomeNavigationItem.shell(
                    label: (context) => Text(e.title),
                    iconData: e.icon,
                    svgIconPath: e.svgIconPath,
                    matchingRoutePrefixes: [],
                    enableLowerDivider: e.includeBottomDivider,
                    subitems: e.children!
                        .map(
                          (e) => HomeNavigationSubItem(
                            label: (context) => Text(e.title),
                            onNavigate: () {
                              context.goNamed(e.path);
                            },
                            routeNamePrefix: '',
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return HomeNavigationItem.simple(
                    label: (context) => Text(e.title),
                    iconData: e.icon,
                    svgIconPath: e.svgIconPath,
                    matchingRoutePrefixes: [],
                    onNavigate: () {
                      context.goNamed(e.path);
                    },
                    enableLowerDivider: e.includeBottomDivider,
                  );
                }
              },
            ).toList(),
          ),
        ),
        Expanded(
          child: widget.child,
        ),
      ],
    );
  }
}
