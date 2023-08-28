// import 'package:e2_explorer/src/features/common_widgets/hf_dropdown/dropdown_search_item.dart';
// import 'package:e2_explorer/src/features/common_widgets/hf_dropdown/hf_dropdown.dart';
// import 'package:e2_explorer/src/features/common_widgets/hf_tree/index.dart';
// import 'package:e2_explorer/src/styles/color_styles.dart';
// import 'package:e2_explorer/src/styles/color_styles.dart';
// import 'package:e2_explorer/src/styles/text_styles.dart';
// import 'package:carbon_icons/carbon_icons.dart';
// import 'package:flutter/material.dart';
//
// class PayloadFilterDropdown extends StatefulWidget {
//   const PayloadFilterDropdown({
//     super.key,
//     this.onCheckedItemsChanged,
//   });
//
//   final void Function(Iterable<Location> items)? onCheckedItemsChanged;
//
//   @override
//   State<PayloadFilterDropdown> createState() => _LocationsFilterDropdownState();
// }
//
// class _LocationsFilterDropdownState extends State<PayloadFilterDropdown> {
//   late final OverlayController overlayController;
//   late final LocationsTreeController treeController;
//
//   Iterable<Location> _checkedItems = <Location>[];
//
//   @override
//   void initState() {
//     super.initState();
//     overlayController = OverlayController('Locations Filter Dropdown');
//     onInit();
//   }
//
//   Future<void> onInit() async {
//     treeController = LocationsTreeController(
//       roots: await LocationRepository().getClientLocationsTree(),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   String _currentSearchQuery = '';
//
//   void filterLocationsTree(String filter) {
//     treeController
//       ..filter(
//         condition: (Location location) {
//           return location.name.toLowerCase().contains(filter);
//         },
//         resultTransformer: (Location oldNode, Iterable<Location> newChildren) =>
//             oldNode.copyWith(children: newChildren.toList()),
//       )
//       ..expandMatchingNodes(
//         (TreeNode<Location> node) => node.data.name.toLowerCase().contains(filter),
//       );
//   }
//
//   String getDisplayText() {
//     if (_checkedItems.isEmpty) {
//       return 'Location';
//     }
//     return _checkedItems.length > 1 ? '${_checkedItems.length} locations' : _checkedItems.first.name;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return HFDropdown(
//       contentWidth: 300,
//       buttonBuilder: (BuildContext context, DropdownButtonOnTap onButtonTap) => ToolbarButton(
//         text: getDisplayText(),
//         onTap: onButtonTap,
//         icon: CarbonIcons.location,
//         buttonColor: Colors.transparent,
//         color: ColorStyles.light100,
//       ),
//       maxContentHeight: 200,
//       contentShellBuilder: (BuildContext context, Widget content) => Container(
//         decoration: BoxDecoration(
//           color: const Color(0xff2b2b2b),
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           border: Border.all(color: const Color(0xff454545)),
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: ClipRRect(
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           child: content,
//         ),
//       ),
//       contentBuilder: (BuildContext context, OverlayController overlay) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             DropdownSearchItem(
//               onChanged: (String searchQuery) {
//                 _currentSearchQuery = searchQuery;
//                 if (searchQuery.isEmpty) {
//                   treeController.clearFilter();
//                   return;
//                 }
//                 final String searchQueryLower = searchQuery.toLowerCase();
//                 filterLocationsTree(searchQueryLower);
//               },
//             ),
//             const Divider(
//               color: Color(0xff454545),
//               height: 1,
//             ),
//             Flexible(
//               child: SingleChildScrollView(
//                 child: LocationsTree(
//                   showCheckboxes: true,
//                   controller: treeController,
//                   onCheckedItemsChanged: (Iterable<Location> items) {
//                     setState(
//                       () {
//                         _checkedItems = items;
//                       },
//                     );
//                     widget.onCheckedItemsChanged?.call(items);
//                   },
//                   emptyStateBuilder: (_) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Text(
//                         'No location: $_currentSearchQuery',
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: TextStyles.small14regular(color: ColorStyles.lightGrey),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
