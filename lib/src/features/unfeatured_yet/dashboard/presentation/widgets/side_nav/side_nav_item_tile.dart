import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/design/colors.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/side_nav/side_nav_sub_item_tile.dart';
import 'package:flutter/material.dart';

class SideNavItemTile extends StatefulWidget {
  const SideNavItemTile({
    super.key,
    required this.item,
    this.isExpanded = false,
  });

  final HomeNavigationItem item;
  final bool isExpanded;

  @override
  State<SideNavItemTile> createState() => _SideNavItemTileState();
}

class _SideNavItemTileState extends State<SideNavItemTile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => _onTap(context),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 12),
                    IconTheme(
                      data: IconThemeData(
                        color: HFColors.light100,
                      ),
                      child: Builder(
                        builder: widget.item.icon,
                      ),
                    ),
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
                        widget.isExpanded
                            ? CarbonIcons.chevron_up
                            : CarbonIcons.chevron_down,
                        color: HFColors.light100,
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
            child: widget.isExpanded
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: HFColors.dark700,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        for (final HomeNavigationSubItem subitem
                            in widget.item.subItems)
                          SideNavSubItemTile(subItem: subitem),
                      ],
                    ),
                  )
                : null,
          ),
      ],
    );
  }

  void _onTap(BuildContext context) {}
}
