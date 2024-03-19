import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/child_size_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_list.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_item_tile.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../network/widgets/selected_network_dropdown_widget.dart';
import '../../../../../profile/presentation/profile.dart';
import '../navigation_item.dart';

class SideNav extends StatefulWidget {
  const SideNav({
    super.key,
    required this.isExpanded,
    required this.items,
    this.selectedIndex = 0,
    required this.onItemTapped,
  });

  static const double collapsedWidth = 86;
  static const double subitemsRailWidth = 300;

  final bool isExpanded;
  final List<HomeNavigationItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  final NavigationItem profileItem = NavigationItem(
    title: 'Profile',
    svgIconPath: AssetUtils.getSidebarIconPath('profile'),
    pageWidget: const ProfilePage(),
    path: RouteNames.profile,
  );
  late final HomeNavigationItem profileHomeNavigationItem;

  @override
  void initState() {
    profileHomeNavigationItem = HomeNavigationItem.simple(
      label: (context) => Text(profileItem.title),
      iconData: profileItem.icon,
      svgIconPath: profileItem.svgIconPath,
      matchingRoutePrefixes: [],
      onNavigate: () {
        context.goNamed(profileItem.path);
            widget.onItemTapped(4);
      },
      enableLowerDivider: profileItem.includeBottomDivider,
    );
    super.initState();
  }

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
                                  child: Stack(
                                    children: [
                                      brandLogoBg(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          /// brand logo
                                          brandLogoWidget(),
                                          const SizedBox(height: 20),

                                          /// selected network dropdown
                                          selectedNetworkWidget(),

                                          /// menu items
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics: const ScrollPhysics(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 12),
                                              child: SideNavItemList(
                                                selectedIndex:
                                                    widget.selectedIndex,
                                                items: widget.items,
                                                key: const ValueKey(
                                                  'side-nav-list',
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const SideNavWalletInfoContainer(),
                                          //profile nav
                                          Container(
                                            margin: const EdgeInsets.all(12),
                                            child: SideNavItemTile(
                                              isSelected: widget.selectedIndex==4,
                                              key: ValueKey<HomeNavigationItem>(
                                                profileHomeNavigationItem,
                                              ),
                                              item: profileHomeNavigationItem,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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

class SideNavWalletInfoContainer extends StatelessWidget {
  const SideNavWalletInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.walletInfoContainerBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetUtils.getSvgIconPath('wallet_icon')),
              const SizedBox(width: 6),
              TextWidget('0xD345...34v6', style: CustomTextStyles.text12_600),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextWidget('Black: 25,234,343',
                  style: CustomTextStyles.text12_400_tertiary),
              const SizedBox(width: 14),
              TextWidget('Peers: 5',
                  style: CustomTextStyles.text12_400_tertiary),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: AppColors.walletInfoContainerDividerColor),
          const SizedBox(height: 14),
          Row(
            children: [
              SvgPicture.asset(AssetUtils.getSvgIconPath("ai_expand_logo"),
                  height: 16),
              const SizedBox(width: 6),
              TextWidget(
                "AiXpand token",
                style: CustomTextStyles.text12_600,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "Balance",
                    style: CustomTextStyles.text12_400_tertiary,
                  ),
                  TextWidget(
                    "0",
                    style: CustomTextStyles.text12_700,
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "Pending",
                    style: CustomTextStyles.text12_400_tertiary,
                  ),
                  TextWidget(
                    "0",
                    style: CustomTextStyles.text12_700,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
