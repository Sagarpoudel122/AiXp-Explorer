import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/child_size_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_list.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../network/widgets/selected_network_dropdown_widget.dart';

class SideNav extends StatefulWidget {
  const SideNav({
    super.key,
    required this.isExpanded,
    required this.items,
    this.selectedIndex = 0,
  });

  static const double collapsedWidth = 86;
  static const double subitemsRailWidth = 300;

  final bool isExpanded;
  final List<HomeNavigationItem> items;
  final int selectedIndex;

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
                      color: AppColors.sideNavBgColor,
                      elevation: 4,
                      child: SafeArea(
                        right: false,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          alignment: Alignment.centerLeft,
                          width: Dimens.sideNavWidth,
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
                                      return Stack(
                                        children: [
                                          brandLogoBg(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              brandLogoWidget(),
                                              const SizedBox(height: 20),
                                              selectedNetworkWidget(),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: SideNavItemList(
                                                    items: widget.items,
                                                    key: const ValueKey(
                                                      'side-nav-list',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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

  SizedBox brandLogoBg() {
    return SizedBox(
      height: 120,
      width: Dimens.sideNavWidth,
      child: Center(
        child: Image.asset(
          AssetUtils.getPngIconPath('sidenav/sidenav_waves'),
          height: 120,
        ),
      ),
    );
  }

  Container brandLogoWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: Dimens.sideNavWidth,
      child: Center(
        child: SvgPicture.asset(
          AssetUtils.getSidebarIconPath(
            'brand_logo_and_text',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Padding selectedNetworkWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: SelectedNetworkDropdownWidget(),
    );
  }

  /// Whenever the app navigates to a new route, automatically select it in the side nav if it expanded.
  void _homeNavigationListener(BuildContext context) {}

  void _onHoverEnter(PointerEnterEvent event) {}

  void _onHoverExit(PointerExitEvent event) {}
}
