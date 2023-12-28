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

  final List<Widget> pages;

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
        SideNav(
          isExpanded: false,
          items: [
            NavigationItem(
              title: 'Network status',
              icon: CarbonIcons.network_1,
              pageWidget: Container(),
            ),
            // NavigationItem(
            //   title: 'Box viewer',
            //   icon: CarbonIcons.iot_connect,
            //   pageWidget: Container(),
            // ),
            NavigationItem(
              title: 'Message viewer',
              icon: CarbonIcons.query_queue,
              pageWidget: Container(),
            ),
          ]
              .map(
                (e) => HomeNavigationItem.simple(
                  label: (context) => Text(e.title),
                  icon: (context) => Icon(e.icon),
                  matchingRoutePrefixes: [],
                  onNavigate: () {},
                  enableLowerDivider: true,
                ),
              )
              .toList(),
        ),
        if (widget.pages.isNotEmpty)
          Expanded(
            child: IndexedStack(
              index: _navIndex,
              children: widget.pages,
            ),
          )
        else
          const Spacer(),
      ],
    );
  }
}
