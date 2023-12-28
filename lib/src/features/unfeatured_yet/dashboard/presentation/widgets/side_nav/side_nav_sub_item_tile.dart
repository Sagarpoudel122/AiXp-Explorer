import 'package:e2_explorer/src/design/colors.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:flutter/material.dart';

class SideNavSubItemTile extends StatelessWidget {
  const SideNavSubItemTile({super.key, required this.subItem});

  final HomeNavigationSubItem subItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: <Widget>[
                // if (subItem == homeNavigationBloc.state.currentSubItem)
                //   Container(
                //     height: 8,
                //     width: 8,
                //     margin: const EdgeInsets.only(
                //       right: 12,
                //     ),
                //     decoration: BoxDecoration(
                //       color: HFColors.blue,
                //       borderRadius: BorderRadius.circular(2),
                //     ),
                //   )
                // else
                //   const SizedBox(width: 20),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: HFColors.light100,
                    ),
                    overflow: TextOverflow.ellipsis,
                    child: Builder(
                      builder: subItem.label,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context) {
    subItem.onNavigate.call();
  }
}
