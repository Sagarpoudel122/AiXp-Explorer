import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/child_size_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_list.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_rail_subitem_list.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class SideNav extends StatefulWidget {
  const SideNav({
    super.key,
    required this.isExpanded,
    required this.items,
  });

  static const double collapsedWidth = 86;
  static const double subitemsRailWidth = 300;

  final bool isExpanded;
  final List<HomeNavigationItem> items;

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.deferToChild,
      onExit: _onHoverExit,
      child: Stack(
        children: <Widget>[
          /// List of subitems that only appears in rail format
          Positioned.fill(
            left: 180,
            right: null,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeOut,
              layoutBuilder:
                  (Widget? currentChild, List<Widget> previousChildren) =>
                      Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
              child: const SideNavRailSubItemList(),
            ),
          ),

          /// Main side nav component
          Positioned.fill(
            right: null,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
              child: widget.isExpanded
                  ? const SizedBox.shrink()
                  : Material(
                      color: ColorStyles.dark800,
                      shape: const Border(
                        right: BorderSide(
                          color: ColorStyles.dark700,
                        ),
                      ),
                      elevation: 4,
                      child: SafeArea(
                        right: false,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          alignment: Alignment.centerLeft,
                          width: 180,
                          child: ClipRect(
                            child: OverflowBox(
                              alignment: Alignment.centerLeft,
                              maxWidth: double.infinity,
                              child: ChildSizeListener(
                                listenHeight: false,
                                onChanged: (Size size) {},
                                child: IntrinsicWidth(
                                  child: Scrollable(
                                    viewportBuilder: (BuildContext context,
                                        ViewportOffset position) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: SideNavItemList(
                                              items: widget.items,
                                              key: const ValueKey(
                                                  'side-nav-list'),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          /// Mouse region for determining wether to show or hide the nav bar.
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 0,
            bottom: 0,
            left: 0,
            width: 32,
            child: MouseRegion(
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: _onHoverEnter,
            ),
          ),
        ],
      ),
    );
  }

  /// Whenever the app navigates to a new route, automatically select it in the side nav if it expanded.
  void _homeNavigationListener(BuildContext context) {}

  void _onHoverEnter(PointerEnterEvent event) {}

  void _onHoverExit(PointerExitEvent event) {}
}
