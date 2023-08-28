import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/left_navigation_menu.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/navigation_item.dart';
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
        LeftNavigationMenu(
          navigationIndexChanged: (index) {
            setState(() {
              _navIndex = index;
            });
          },
          navigationItems: [
            NavigationItem(
              title: 'Mqtt Status',
              icon: CarbonIcons.ai_status,
              pageWidget: Container(),
            ),
            NavigationItem(
              title: 'Box viewer',
              icon: CarbonIcons.iot_connect,
              pageWidget: Container(),
            ),
            NavigationItem(
              title: 'Message viewer',
              icon: CarbonIcons.query_queue,
              pageWidget: Container(),
            ),
            NavigationItem(
              title: 'Network monitor',
              icon: CarbonIcons.network_1,
              pageWidget: Container(),
            ),
            // NavigationItem(
            //   title: 'Stress test',
            //   icon: CarbonIcons.stress_breath_editor,
            //   pageWidget: Container(),
            // ),
            // NavigationItem(
            //   title: 'Message Watcher - DEV',
            //   icon: CarbonIcons.stress_breath_editor,
            //   pageWidget: Container(),
            // ),
          ],
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
