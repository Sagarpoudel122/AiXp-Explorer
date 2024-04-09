import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_sub_item_tile.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/dimens.dart';

class SideNavItemTile extends StatefulWidget {
  const SideNavItemTile({
    super.key,
    required this.item,
    required this.isSelected,

  });

  final HomeNavigationItem item;
  final bool isSelected;


  @override
  State<SideNavItemTile> createState() => _SideNavItemTileState();
}

class _SideNavItemTileState extends State<SideNavItemTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = widget.isSelected;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimens.sideNavListItemBorderRadius,
            ),
            color: isCurrent ? AppColors.sideNavSelectedTileBgColor : null,
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              Dimens.sideNavListItemBorderRadius,
            ),
            onTap: () {
             

              if (widget.item.onNavigate != null) widget.item.onNavigate!();
              if (widget.item.subItems.isNotEmpty) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              }
            },
            hoverColor: AppColors.sideNavSelectedTileBgColor,
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(width: 4),
                      // if (false) ...<Widget>[
                      if (widget.item.svgIconPath != null) ...<Widget>[
                        Container(
                          width: 34,
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            widget.item.svgIconPath!,
                            color: isCurrent
                                ? AppColors.sideNavSelectedTileIconColor
                                : AppColors.sideNavUnselectedTileIconColor,
                          ),
                        ),
                      ] else if (widget.item.iconData != null) ...<Widget>[
                        Container(
                          width: 34,
                          alignment: Alignment.centerLeft,
                          child: IconTheme(
                            data: IconThemeData(
                              color: isCurrent
                                  ? AppColors.sideNavSelectedTileIconColor
                                  : AppColors.sideNavUnselectedTileIconColor,
                            ),
                            child: Icon(widget.item.iconData),
                          ),
                        ),
                      ],
                      // const SizedBox(width: 8),
                      Expanded(
                        child: DefaultTextStyle(
                          style: TextStyles.sideNavTileTextStyle(
                            isSelected: isCurrent,
                          ),
                          maxLines: 1,
                          child: Builder(
                            builder: widget.item.label,
                          ),
                        ),
                      ),
                      if (widget.item.subItems.isNotEmpty) ...<Widget>[
                        const SizedBox(width: 8),
                        Icon(
                          isExpanded
                              ? CarbonIcons.chevron_up
                              : CarbonIcons.chevron_down,
                          color: isCurrent
                              ? AppColors.sideNavSelectedTileIconColor
                              : AppColors.sideNavUnselectedTileIconColor,
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.isSelected)
                  Positioned.fill(
                    right: null,
                    child: Container(
                      width: 8,
                      decoration: BoxDecoration(
                        color: AppColors.sideNavSelectedTileIndicatorColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.item.subItems.isNotEmpty)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                SizeTransition(
              sizeFactor: animation,
              axisAlignment: 1,
              child: child,
            ),
            child: isExpanded
                ? Column(
                    children: <Widget>[
                      for (final HomeNavigationSubItem subitem
                          in widget.item.subItems)
                        SideNavSubItemTile(subItem: subitem),
                    ],
                  )
                : null,
          ),
      ],
    );
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (widget.item.onNavigate != null) widget.item.onNavigate!();
            if (widget.item.subItems.isNotEmpty) {
              setState(() {
                isExpanded = !isExpanded;
              });
            }
          },
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 12),
                    if (widget.item.svgIconPath != null) ...<Widget>[
                      Container(
                        width: 34,
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          widget.item.svgIconPath!,
                          color: isCurrent
                              ? AppColors.sideNavSelectedTileIconColor
                              : AppColors.sideNavUnselectedTileIconColor,
                        ),
                      ),
                    ] else if (widget.item.iconData != null) ...<Widget>[
                      Container(
                        width: 34,
                        alignment: Alignment.centerLeft,
                        child: IconTheme(
                          data: IconThemeData(
                            color: isCurrent
                                ? AppColors.sideNavSelectedTileIconColor
                                : AppColors.sideNavUnselectedTileIconColor,
                          ),
                          child: Icon(widget.item.iconData),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),
                    Expanded(
                      child: DefaultTextStyle(
                        style: const TextStyle(),
                        maxLines: 1,
                        child: Builder(
                          builder: widget.item.label,
                        ),
                      ),
                    ),
                    if (widget.item.subItems.isNotEmpty) ...<Widget>[
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded
                            ? CarbonIcons.chevron_up
                            : CarbonIcons.chevron_down,
                        color: ColorStyles.light100,
                        size: 16,
                      ),
                    ],
                  ],
                ),
              ),
              // if (isCurrent)
              //   Positioned.fill(
              //     right: null,
              //     child: FractionallySizedBox(
              //       heightFactor: 2 / 3,
              //       child: Container(
              //         width: 4,
              //         decoration: BoxDecoration(
              //           color: HFColors.blue,
              //           borderRadius: BorderRadius.horizontal(
              //             right: Radius.circular(4),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        if (widget.item.subItems.isNotEmpty)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                SizeTransition(
              sizeFactor: animation,
              axisAlignment: 1,
              child: child,
            ),
            child: isExpanded
                ? DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: ColorStyles.dark700,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        for (final HomeNavigationSubItem subitem
                            in widget.item.subItems)
                          SideNavSubItemTile(
                            subItem: subitem,
                          ),
                      ],
                    ),
                  )
                : null,
          ),
      ],
    );
  }
}
