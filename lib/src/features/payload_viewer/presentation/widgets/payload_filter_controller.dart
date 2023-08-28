// import 'package:e2_explorer/src/features/common_widgets/hf_tree/index.dart';
//
// class TreeItemCheckedEvent<TreeItemDataType extends Object> {
//   TreeItemCheckedEvent({
//     required this.item,
//     required this.checked,
//   });
//   TreeItemDataType item;
//   bool checked;
// }
//
// class LocationsTreeController extends TreeController<Location> {
//   LocationsTreeController({required Iterable<Location> roots})
//       : super(
//           dataSource: LocationTreeDataSource(roots: roots),
//         );
//
//   final Map<String, int> _checkedDescendantsCount = <String, int>{};
//
//   @override
//   LocationTreeDataSource get dataSource => super.dataSource as LocationTreeDataSource;
//
//   @override
//   void filter({
//     required NodeMatchCondition<Location> condition,
//     required FilterResultTransformer<Location> resultTransformer,
//   }) {
//     if (!super.dataSource.isFiltered) {
//       // Save expanded locations before applying first filter
//       _expandedLocationsBeforeFilter = Set<String>.from(_expandedLocations);
//     }
//     super.filter(condition: condition, resultTransformer: resultTransformer);
//   }
//
//   @override
//   void clearFilter() {
//     super.clearFilter();
//     // Restore expanded locations before filter
//     _expandedLocations = Set<String>.from(_expandedLocationsBeforeFilter);
//     rebuild(animate: false);
//   }
//
//   final Map<String, Location> _checkedItems = <String, Location>{};
//
//   final StreamController<TreeItemCheckedEvent<Location>> _itemCheckedEventsStream =
//       StreamController<TreeItemCheckedEvent<Location>>.broadcast();
//
//   Stream<TreeItemCheckedEvent<Location>> get onItemCheckedChanged => _itemCheckedEventsStream.stream;
//
//   void notifyItemCheckedChange(Location item, {required bool checked}) {
//     if (_itemCheckedEventsStream.hasListener) {
//       _itemCheckedEventsStream.sink.add(TreeItemCheckedEvent<Location>(item: item, checked: checked));
//     }
//   }
//
//   bool isItemChecked(Location item) {
//     return _checkedItems.containsKey(item.uuid);
//   }
//
//   bool hasCheckedDescendants(Location item) =>
//       _checkedDescendantsCount.containsKey(item.uuid) && _checkedDescendantsCount[item.uuid]! > 0;
//
//   void _updateParentsDescendantCount(Location item, bool checked) {
//     Location? currentParent = dataSource.getParent(item);
//
//     while (currentParent != null) {
//       int descendantsCount = _checkedDescendantsCount[currentParent.uuid] ?? 0;
//       if (checked) {
//         descendantsCount += 1;
//       } else {
//         descendantsCount -= 1;
//       }
//       _checkedDescendantsCount[currentParent.uuid] = descendantsCount;
//       currentParent = dataSource.getParent(currentParent);
//     }
//   }
//
//   void setItemChecked(Location item, {required bool checked}) {
//     _updateParentsDescendantCount(item, checked);
//     if (checked) {
//       _checkedItems[item.uuid] = item;
//     } else {
//       _checkedItems.remove(item.uuid);
//     }
//     notifyItemCheckedChange(item, checked: checked);
//     rebuild();
//   }
//
//   void toggleItemChecked(Location item) {
//     setItemChecked(item, checked: !isItemChecked(item));
//     rebuild();
//   }
//
//   void updateChildInParent(Location parent, Location newLocation) {
//     parent.children
//       ..removeWhere((Location element) => element.uuid == newLocation.uuid)
//       ..add(newLocation)
//       ..sort((Location a, Location b) => a.name.compareTo(b.name));
//   }
//
//   Iterable<Location> get checkedItems {
//     return _checkedItems.keys.map((String uuid) => dataSource.getLocationById(uuid)!);
//   }
//
//   final Set<String> loadingItems = <String>{};
//
//   Set<String> _expandedLocations = <String>{};
//   Set<String> _expandedLocationsBeforeFilter = <String>{};
//
//   @override
//   void clearExpandedItems() {
//     _expandedLocations.clear();
//   }
//
//   @override
//   bool isItemExpanded(Location item) => _expandedLocations.contains(item.uuid);
//
//   @override
//   void setItemExpanded(Location item, {required bool expanded}) {
//     expanded ? _expandedLocations.add(item.uuid) : _expandedLocations.remove(item.uuid);
//   }
//
//   Location? _selectedItem;
//
//   @override
//   Location? get selectedItem => _selectedItem;
//
//   @override
//   set selectedItem(Location? item) {
//     _selectedItem = item;
//     rebuild();
//   }
//
//   bool isSelected(Location item) {
//     if (_selectedItem == null) {
//       return false;
//     }
//     return _selectedItem!.uuid == item.uuid;
//   }
// }
