import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/table_status_button.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:flutter/cupertino.dart';

import '../../../../common_widgets/buttons/refresh_button_with_animation.dart';
import '../../../../common_widgets/table/flr_table.dart';
import '../../../../common_widgets/table/flr_table_types.dart';
import '../../../../common_widgets/table/sync_scroll_controller.dart';
import '../../../../common_widgets/table/table_header_item_widget.dart';

class NetmonTableNew extends StatefulWidget {
  const NetmonTableNew(
      {super.key, required this.netmonBoxes, this.onBoxSelected});

  final List<NetmonBox> netmonBoxes;
  final void Function(NetmonBox)? onBoxSelected;

  @override
  State<NetmonTableNew> createState() => _NetmonTableNewState();
}

class _NetmonTableNewState extends State<NetmonTableNew> {
  final SyncScrollController verticalSyncController = SyncScrollController();
  final SyncScrollController horizontalSyncController = SyncScrollController();

  double _columnWidth(NetmonBoxColumn header) {
    switch (header) {
      default:
        return 200;
    }
  }

  Future<void> _onEdit(NetmonBox ioDevice) async {
    // final NetmonBoxListBloc ioDeviceListBloc = context.read<NetmonBoxListBloc>();
    // final NetmonBoxDto ioDeviceDto = await NetmonBoxRepository().getNetmonBoxDto(ioDevice.uuid!);
    //
    // bool? result;
    //
    // if (ioDevice.actionable) {
    //   final NetmonBox controller = await NetmonBoxRepository().getControllerForGpio(
    //     ioDevice.gpio!.first.connectedTo!.uuid,
    //   );
    //
    //   if (mounted) {
    //     result = await showAddEditActionable(
    //       context: context,
    //       ioDeviceDto: ioDeviceDto,
    //       controller: controller,
    //     );
    //   }
    // } else {
    //   if (mounted) {
    //     result = await showAddEditController(context: context, ioDeviceDto: ioDeviceDto);
    //   }
    // }
    //
    // if (result ?? false) {
    //   ioDeviceListBloc.add(NetmonBoxListFetchByType());
    // }
  }

  Future<void> _onTap(int index) async {
    // final NetmonBoxListBloc ioDeviceListBloc = context.read<NetmonBoxListBloc>();
    // final NetmonBox ioDevice = ioDeviceListBloc.state.ioDevices.data[index];
    //
    // await _onEdit(ioDevice);
    widget.onBoxSelected?.call(widget.netmonBoxes[index]);
  }

  void _onRefresh() {
    // context.read<NetmonBoxListBloc>().add(NetmonBoxListFetchByType());
  }

  void _onSortChanged(NetmonBoxColumn value) {
    // final PagedContentBloc pagedContentBloc = context.read<PagedContentBloc>();
    // final String? sortBy = pagedContentBloc.state.queryParams.sortBy;
    // final bool ascending = pagedContentBloc.state.queryParams.ascending;
    // if (sortBy == value.name && ascending) {
    //   pagedContentBloc.add(
    //     PagedContentChangeQueryParams(
    //       queryParams: pagedContentBloc.state.queryParams.copyWith(
    //         sortBy: value.name,
    //         ascending: false,
    //       ),
    //     ),
    //   );
    // } else if (sortBy == value.name && !ascending) {
    //   pagedContentBloc.add(
    //     PagedContentChangeQueryParams(
    //       queryParams: pagedContentBloc.state.queryParams.copyWith(
    //         sortBy: '',
    //         ascending: true,
    //       ),
    //     ),
    //   );
    // } else {
    //   pagedContentBloc.add(
    //     PagedContentChangeQueryParams(
    //       queryParams: pagedContentBloc.state.queryParams.copyWith(
    //         sortBy: value.name,
    //         ascending: true,
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  void dispose() {
    verticalSyncController.dispose();
    horizontalSyncController.dispose();
    super.dispose();
  }

  static FLRTableLabels flrTableLabels = FLRTableLabels(
    filters: (BuildContext context) => 'Filters',
    hideColumns: (BuildContext context) => 'Hide Columns',
    hiddenColumn: (BuildContext context) => 'Hidden Column',
    $1hiddenColumns: (BuildContext context) => 'Hidden columns',
    refreshButton: RefreshButtonWithAnimationLabels(
      refresh: (BuildContext context) => 'Refresh',
      loading: (BuildContext context) => 'Loading',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FLRTable<NetmonBox, NetmonBoxColumn>(
      labels: flrTableLabels,
      columns: NetmonBoxColumn.values,
      columnsLeft: const <NetmonBoxColumn>[NetmonBoxColumn.boxId],
      columnsRight: const <NetmonBoxColumn>[],
      visibleColumns: NetmonBoxColumn.values.toSet(),
      sortingColumns: NetmonBoxColumn.values
          .where((NetmonBoxColumn e) => e.sortable)
          .toSet(),
      sortedColumn: null,
      // sortedColumn: NetmonBoxColumn.values
      //     .where((NetmonBoxColumn e) => e.sortable)
      //     .byNameOrNull(queryParams.sortBy ?? ''),
      items: widget.netmonBoxes,
      rowHeight: (_) => Dimens.tableBodyRowHeight,
      headerBuilder: (FLRHeaderInfo<NetmonBoxColumn> header) {
        return TableHeaderItemWidget(
          title: header.title,
          showSort: header.canSortBy,
          isSorted: header.isSortedBy,
          sortIsAscending: true,
          onSortClick: () => _onSortChanged(header.columnType),
        );
      },
      headerTitle: (NetmonBoxColumn column) {
        switch (column) {
          case NetmonBoxColumn.boxId:
            return 'Box ID';
          case NetmonBoxColumn.version:
            return 'Version';
          case NetmonBoxColumn.working:
            return 'Working';
          case NetmonBoxColumn.uptime:
            return 'Uptime';
          case NetmonBoxColumn.lastSeen:
            return 'Last seen';
          case NetmonBoxColumn.security:
            return 'Security';
          case NetmonBoxColumn.score:
            return 'Score';
          case NetmonBoxColumn.trust:
            return 'Trust';
          case NetmonBoxColumn.notes:
            return 'Notes';
          case NetmonBoxColumn.superColumn:
            return 'Super';
        }
      },
      columnWidth: _columnWidth,

      rowBuilder: (NetmonBox box, List<NetmonBoxColumn> columns) {
        return columns.map((NetmonBoxColumn columnType) {
          switch (columnType) {
            case NetmonBoxColumn.boxId:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child:
                    TextWidget(box.boxId, style: CustomTextStyles.text14_400),
              );
            case NetmonBoxColumn.version:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextWidget(
                  box.details.version.split(' ')[0],
                  style: CustomTextStyles.text14_400,
                ),
              );
            case NetmonBoxColumn.working:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TableStatusButton(
                  text: box.details.working,
                  tsbStatus: box.details.working.toLowerCase() == 'online'
                      ? TsbStatus.success
                      : TsbStatus.error,
                ),
              );
            case NetmonBoxColumn.uptime:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextWidget(box.details.uptime,
                    style: CustomTextStyles.text14_400),
              );
            case NetmonBoxColumn.lastSeen:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextWidget(
                  timeAgoString(box.details.lastSeenSec.toInt()),
                  style: CustomTextStyles.text14_400,
                ),
              );
            case NetmonBoxColumn.security:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TableStatusButton(
                  text: box.details.trustInfo,
                  tsbStatus: box.details.trustInfo.toLowerCase() == 'secure'
                      ? TsbStatus.success
                      : TsbStatus.error,
                ),
              );
            case NetmonBoxColumn.score:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextWidget(
                  '${box.details.score}',
                  style: CustomTextStyles.text14_400,
                ),
              );
            case NetmonBoxColumn.trust:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TableStatusButton(
                  text: '${(box.details.trust * 100).toStringAsFixed(1)}%',
                  tsbStatus: box.details.trust > 0.75
                      ? TsbStatus.success
                      : box.details.trust > 0.5
                          ? TsbStatus.warning
                          : TsbStatus.error,
                ),
              );
            case NetmonBoxColumn.notes:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextWidget(
                  box.details.nodeTz,
                  style: CustomTextStyles.text14_400,
                ),
              );
            case NetmonBoxColumn.superColumn:
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TableStatusButton(
                  text: box.details.isSupervisor ? 'YES' : 'NO',
                  tsbStatus: box.details.isSupervisor
                      ? TsbStatus.success
                      : TsbStatus.error,
                ),
              );
          }
        }).toList();
      },
      onTap: _onTap,
      onRefresh: _onRefresh,
      isLoading: false,
      // isLoading: ioDeviceListBloc.state.isLoading,
    );
  }
}
