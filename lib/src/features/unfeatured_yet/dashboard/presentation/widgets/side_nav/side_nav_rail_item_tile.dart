import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_item.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class SideNavItemRailTile extends StatefulWidget {
  const SideNavItemRailTile({super.key, required this.item});

  final HomeNavigationItem item;

  @override
  State<SideNavItemRailTile> createState() => _SideNavItemRailTileState();
}

class _SideNavItemRailTileState extends State<SideNavItemRailTile> {
  final FocusNode _focusNode = FocusNode();

  bool hovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: _focusNode,
      onTap: _onTap,
      onHover: _onHover,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          // width: SideNav.collapsedWidth,
          width: 80,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              if (widget.item.subItems.isNotEmpty)
                const Positioned(
                  top: 6,
                  right: 12,
                  child: Icon(
                    CarbonIcons.overflow_menu_horizontal,
                    color: ColorStyles.dark600,
                    size: 16,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconTheme(
                      data: const IconThemeData(
                        color: ColorStyles.light100,
                      ),
                      child: Builder(
                        builder: widget.item.icon,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DefaultTextStyle(
                      style: const TextStyle(),
                      textAlign: TextAlign.center,
                      child: Builder(
                        builder: widget.item.label,
                      ),
                    ),
                  ],
                ),
              ),
              // if (widget.item == homeNavigationBloc.state.currentItem)
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
      ),
    );
  }

  void _focusNodeListener() {}

  void _onTap() {
    // final SideNavBloc sideNavBloc = context.read<SideNavBloc>();
    // if (_focusNode.hasFocus) {
    //   _focusNode.unfocus();
    // } else if (widget.item.subItems.isNotEmpty) {
    //   _focusNode.requestFocus();
    // }
    // if (hovering) {
    //   sideNavBloc.add(SideNavSetHighlightedItem(item: widget.item));
    // }
    // widget.item.onNavigate?.call();
  }

  Future<void> _onHover(bool value) async {
    // final SideNavBloc sideNavBloc = context.read<SideNavBloc>();
    // setState(() => hovering = value);

    // if (value) {
    //   /// Delay the highlight event if any other item is currently highlighted.
    //   /// This avoids accidental highlighting when the user tries to select subitems.
    //   if (sideNavBloc.state.isAnyHighlighted) {
    //     await Future<void>.delayed(const Duration(milliseconds: 100));
    //   }
    //   if (hovering &&
    //       !sideNavBloc.state.isAnySelected &&
    //       !sideNavBloc.isClosed) {
    //     sideNavBloc.add(SideNavSetHighlightedItem(item: widget.item));
    //   }
    // }
  }
}
