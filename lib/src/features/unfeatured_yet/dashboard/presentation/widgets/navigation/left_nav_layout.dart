import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/left_navigation_menu.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav.dart';
import 'package:flutter/material.dart';

class LeftNavLayout extends StatefulWidget {
  const LeftNavLayout({
    super.key,
    this.pages = const [],
  });

  final List<NavigationItem> pages;

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
          width: 180,
          child: SideNav(
            isExpanded: false,
            items: widget.pages
                .map(
                  (e) => HomeNavigationItem.simple(
                    label: (context) => Text(e.title),
                    icon: (context) => Icon(e.icon),
                    matchingRoutePrefixes: [],
                    onNavigate: () {
                      setState(() {
                        _navIndex = widget.pages.indexOf(e);
                      });
                    },
                    enableLowerDivider: true,
                  ),
                )
                .toList(),
          ),
        ),
        if (widget.pages.isNotEmpty)
          Expanded(
            child: IndexedStack(
              index: _navIndex,
              children: widget.pages.map((e) => e.pageWidget).toList(),
            ),
          )
        else
          const Spacer(),
      ],
    );
  }
}
