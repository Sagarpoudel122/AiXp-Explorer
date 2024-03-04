import 'package:e2_explorer/src/data/constant_string_code.dart';
import 'package:e2_explorer/src/features/command_launcher/model/command_launcher_data.dart';
import 'package:e2_explorer/src/features/command_launcher/presentation/command_launcher_page.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_primary.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/refresh_button_with_animation.dart';
import 'package:e2_explorer/src/features/common_widgets/table/flr_table.dart';
import 'package:e2_explorer/src/features/common_widgets/table/sticky_header_table.dart';
import 'package:e2_explorer/src/features/common_widgets/table/table_header_item_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/config_startup/widgets/dialouges/edit_dialouges.dart';
import 'package:e2_explorer/src/features/dashboard/presentation/widget/dashboard_body_container.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfigStartUp extends StatelessWidget {
  const ConfigStartUp({super.key});

  @override
  Widget build(BuildContext context) {
    FLRTableLabels flrTableLabels = FLRTableLabels(
      filters: (BuildContext context) => 'Filters',
      hideColumns: (BuildContext context) => 'Hide Columns',
      hiddenColumn: (BuildContext context) => 'Hidden Column',
      $1hiddenColumns: (BuildContext context) => 'Hidden columns',
      refreshButton: RefreshButtonWithAnimationLabels(
        refresh: (BuildContext context) => 'Refresh',
        loading: (BuildContext context) => 'Loading',
      ),
    );
    return DashboardBodyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: TextWidget('Config Startup',
                style: CustomTextStyles.text20_700),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: FLRTable<CommandLauncherData, CommandLauncherColumns>(
              expandLastColumn: true,
              columns: CommandLauncherColumns.values,
              columnsLeft: const [],
              columnsRight: const [],
              visibleColumns: CommandLauncherColumns.values.toSet(),
              sortingColumns: const {},
              sortedColumn: null,
              items: [
                CommandLauncherData(
                  edgeNode: 'Goliath',
                  configStartupFile: 'configStartupFile',
                ),
                CommandLauncherData(
                  edgeNode: 'gts-test 1',
                  configStartupFile: 'configStartupFile',
                ),
                CommandLauncherData(
                  edgeNode: 'gts-staging',
                  configStartupFile: 'configStartupFile',
                ),
              ],
              rowBuilder: (item, columns) {
                return columns.map((column) {
                  return switch (column) {
                    CommandLauncherColumns.edgeNode => Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextWidget(item.edgeNode,
                            style: CustomTextStyles.text14_400),
                      ),
                    CommandLauncherColumns.configStartupFile => Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Row(
                          children: [
                            AppButtonSecondary(
                              onPressed: () {
                                showAppDialog(
                                  context: context,
                                  content: AppDialogWidget(
                                    isActionbuttonReversed: true,
                                    positiveActionButtonText: "Download Json",
                                    negativeActionButtonText: "Close",
                                    title:
                                        "Config Startup file for ${item.edgeNode}",
                                    content: SizedBox(
                                        height: 500,
                                        child: SingleChildScrollView(
                                            child: SizedBox(
                                          width: double.maxFinite,
                                          child: XMLViwer(
                                            content: jsonString,
                                            type: "json",
                                          ),
                                        ))),
                                  ),
                                );
                              },
                              text: 'View',
                              height: 30,
                              minWidth: 100,
                              icon: SvgPicture.asset(
                                'assets/icons/svg/eye.svg',
                                height: 14,
                                width: 14,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AppButtonSecondary(
                              onPressed: () {
                                showAppDialog(
                                  context: context,
                                  content: EditDialouges(title: item.edgeNode),
                                );
                              },
                              text: 'Edit',
                              height: 30,
                              minWidth: 100,
                              icon: SvgPicture.asset(
                                'assets/icons/svg/edit.svg',
                                height: 14,
                                width: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                  };
                }).toList();
              },
              headerBuilder: (header) {
                return TableHeaderItemWidget(
                  title: header.title,
                  showSort: header.canSortBy,
                  isSorted: header.isSortedBy,
                  sortIsAscending: true,
                );
              },
              headerTitle: (columnType) {
                return switch (columnType) {
                  CommandLauncherColumns.edgeNode => 'Edge Node',
                  CommandLauncherColumns.configStartupFile =>
                    'Config Startup File',
                };
              },
              columnWidth: (columnType) {
                final size = MediaQuery.of(context).size;
                return switch (columnType) {
                  CommandLauncherColumns.edgeNode => size.width / 2.5,
                  CommandLauncherColumns.configStartupFile => size.width / 2.5,
                };
              },
              onTap: (value) async {},
              onRefresh: () {},
              rowHeight: (_) => Dimens.tableBodyRowHeight + 10,
              isLoading: false,
              labels: flrTableLabels,
            ),
          )

          /// Todo: Table here
          // Container(
          //   color: Colors.green,
          //   width: double.maxFinite,
          //   height: 500,
          // )
        ],
      ),
    );
  }
}
