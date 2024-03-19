import 'dart:convert';
import 'dart:io';

import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';

import 'package:e2_explorer/src/features/command_launcher/model/command_launcher_data.dart';
import 'package:e2_explorer/src/features/command_launcher/presentation/command_launcher_page.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/refresh_button_with_animation.dart';
import 'package:e2_explorer/src/features/common_widgets/table/flr_table.dart';
import 'package:e2_explorer/src/features/common_widgets/table/table_header_item_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/config_startup/widgets/dialouges/edit_dialouges.dart';
import 'package:e2_explorer/src/features/dashboard/presentation/widget/dashboard_body_container.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfigStartUp extends StatefulWidget {
  const ConfigStartUp({super.key});

  @override
  State<ConfigStartUp> createState() => _ConfigStartUpState();
}

class _ConfigStartUpState extends State<ConfigStartUp> {
  List<NetmonBox> netmonStatusList = [];
  final period = const Duration(seconds: 5);
  Map<String, NetmonBoxDetails> netmonStatus = {};
  List<String> supervisorIds = [];
  String? currentSupervisor;
  Future<void> editData({
    required CommandLauncherData item,
  }) async {
    final data = {
      "COLLECTED": false,
      "CONFIG_STARTUP":
          "eNqNV1tX4zYQfu7+ipy0j2xuW+iWpwpbSVRsybXlQNrD0TGOFnw2idPYZks5/PeOpDj4Frp54aD5NDOa+ebilw89+PUxFsTuX/b6Wf4gvn7ORFbs5L5/ZqQBtkIfK3m+L+ThkDAxZb6LOMe+uhlHT8mkvOEiQoXDmCd8HDAn5IRRAJ0fxBZzPRAEYo6Rz68w4nXdLtxGC0Qc4WJX8LkyMBpMjtd9womFHKWcgwKwdKOQBvXmNKN23cS41HA8FJy42A9A9iVaZ7IldtisIfOccEZoIBhVjmFkB3XfLeRxiJYAz3ggbBJ4DloC5GJUOjYPuc1uqKAMQKDBbZo3Pgk7dD1BKMR3gRyl4fznAwDfckxtbIsKsu5F6aWNr8KZgEhMCfyZIzrDTWtXDrOuQQQxNziQv2iR0QQZmBIHqxzLyWAnN4ckGykKghvmK25si/X6rH4PNKND6vurKI/6Wvx6MPyjjacodLjArkp1l3EgiospHysFD3Ir90nck5soWfe2aZ58SeIoT9Jt1aEwMHTM0nWSiWgt93n227rYbGS+fx5EyQnn+9VzULE4aNnku8GDMjiI0/rDma8Ydf75l7OWuxN19V6u02+97DEt1qvevezF6fZL8lDs5aqXbFfJU7IqovX6uarTBjoTeozYySfUoljyDdMF8RlV9usxhCq1sABYvRY/jmuWTSYMbWpUMnISIAeqDCgX+g7wzXOgALnm0l9HmIYukpVMg3wvo03/KLmruaziS+jstMtQdZraLIQS8rBPmMrRp4vRqBFsUAH+am7+XchC9jveZOMFsTQkLlbR5ajBFoF07VQq4iiZeuOLdixcdCtuEDGtQ7hggkA0NF/ORy0WAa0dB1uc+RpvY4ej9ltQyBko9d3QUyF9eW3oUdGC+vR8ZkHb7HC3BB0aArEdXHaF8efR+DQS+rBNLF6CL2pYa46ta6EbBGSe0IN9cdDRERsGDxR/MtZVzRoht6tdmmxzlY+fYOxAq4dJAt3MY9DqKrnR6CiOZZaJr/K5jkeW9uMaL5s3MhnvZd6+AePAx/zEDajKFhpqqom8L+KvoHsbbTR8k67k+uO/afrG89caz8smfJLnNnaZUDHryKjp3OzqdyBPd8apLVxEyRS6hsDImgNo8muNVbYtmE/AB5iVxEUz3FHZ7wyI2mOQraayRzzsmIqrvMMEzWUUqmI0bifdyOcs4K05UZFXkvoOqpLI91EqgQbxlp7Kw9XuIKww4Ay6yC22Oh3XTQ/mk8eXiv4hD1oRNMpCKm4In0PDOhHo0zn7NBp3OhhgZypMBXa5Bi35Wi8+nm/pxadcbt4ioSfwO4CynKFm9Ypy3ukHhWhDajudaGoYj5ovDj3VKwLmHyLSaSL0bBgmhkDQKL/H0kXTEgzya9XXIAd+eyypX/tEXxxPLkejRqlXhZ9G/ZbsrnZy13AF2n5A1H7IrjEtG8uMcLVUNIlz2GABfYXnhNrdxCk1wvBV+h7zfJddDof76NvgIckfi/sik3vYMHK5zdWmMnQO68IQJbe7jxgPX16HcbqXQ9hltsMnuR/snk+1LTVYQ0rM6na6ef3BVJgntYlMqVDjEQrUh4LhZrOu0E5Pdl0FygiidnC6I6np7vvMD042R6XMQ0uHmSX8/0HH9qUJcvc+NiAz2MWgi3wXGC2wWpPNx1BjFe7A+xh2eqJY39ls4QNksRTMCzq3YmRxAuZ0iFCwpFZ7C8tgzgq1t7amXfQkRbKJHqRQG3km88qWdtaywagxYz51dCAaXNGDQyWc4AWuOfLSKps+X3q4//Y/UHmdxlHVyR/6yPPKeXRcCwx2MBQaLuIofpRDs1GLaLcb5P/kTTbffXj98B/XFo4H",
      "DEBUG_PAYLOAD_SAVED": false,
      "EE_EVENT_TYPE": "PAYLOAD",
      "EE_FORMATTER": "cavi2",
      "EE_HASH":
          "69d3c920e3dfd79f8d439ac4a4f7a81c838a7388343386e372e973d9fa123e59",
      "EE_ID": "stg_k8s_super",
      "EE_IS_ENCRYPTED": false,
      "EE_MESSAGE_ID": "7c420c3a-03ff-4e86-b156-ee02344241b7",
      "EE_MESSAGE_SEQ": 19019,
      "EE_PAYLOAD_PATH": [
        "stg_k8s_super",
        "admin_pipeline",
        "UPDATE_MONITOR_01",
        "UPDATE_MONITOR_01_INST"
      ],
      "EE_SENDER": "aixp_AyWzxm5uGFWPWGVHrZQt2TgH3xXrJzMw3Go55X4JB86Z",
      "EE_SIGN":
          "MEUCIB_eVJhEXP1CKW5LE0qPOQwvE3N7j7uBMeOfNCOGth4tAiEAvVe3tstvdMn6scyZPg9_olybjCFjnZ3LY74uxgF9kPc=",
      "EE_TIMESTAMP": "2024-03-01 10:44:05.896175",
      "EE_TIMEZONE": "UTC+2",
      "EE_TOTAL_MESSAGES": 19019,
      "EE_TZ": "Europe/Bucharest",
      "EE_VERSION": "3.29.431",
      "ID": 0,
      "ID_TAGS": [],
      "IMG_IN_PAYLOAD": false,
      "IMG_ORIG": null,
      "INITIATOR_ADDR": null,
      "INITIATOR_ID": null,
      "INSTANCE_ID": "UPDATE_MONITOR_01_INST",
      "IS_ALERT": false,
      "IS_ALERT_NEW_LOWER": false,
      "IS_ALERT_NEW_RAISE": false,
      "IS_ALERT_STATUS_CHANGED": false,
      "IS_NEW_LOWER": false,
      "IS_NEW_RAISE": false,
      "MODIFIED_BY_ADDR": "aixp_A6IrUO8pNoZrezX7UhYSjD7mAhpqt-p8wTVNHfuTzg-G",
      "MODIFIED_BY_ID": "SolisClient_SolisClient_bf2d",
      "PIPELINE": "admin_pipeline",
      "SESSION_ID": null,
      "SIGNATURE": "UPDATE_MONITOR_01",
      "STATUS": "N/A",
      "STREAM": "admin_pipeline",
      "STREAM_NAME": "admin_pipeline",
      "TAGS": "",
      "TIMESTAMP_ARRIVAL": "2024-03-01 10:44:05.366516",
      "TIMESTAMP_EXECUTION": "2024-03-01 10:44:05.832726",
      "_P_ALERT_HELPER": "A=0, N=0, CT=NA, E=A[]=0.00 vs >=0.50 ",
      "_P_ALIVE_TIME_MINS": 943.39,
      "_P_DATASET_BUILDER_USED": false,
      "_P_DEBUG_SAVE_PAYLOAD": false,
      "_P_DEMO_MODE": false,
      "_P_GRAPH_TYPE": [],
      "_P_PLUGIN_LOOP_RESOLUTION": 50,
      "_P_PLUGIN_REAL_RESOLUTION": null,
      "_P_PROCESS_DELAY": 60,
      "_P_VERSION": "0.1.0.0"
    };
    showAppDialog(
      context: context,
      content: EditDialouges(title: item.edgeNode, json: data),
    );
  }

  Map<String, dynamic> getJsonData() {
    //TO:DO remove this hardcoded data and get the data after sending the config
    final json = {
      "COLLECTED": false,
      "CONFIG_STARTUP":
          "eNqNV1tX4zYQfu7+ipy0j2xuW+iWpwpbSVRsybXlQNrD0TGOFnw2idPYZks5/PeOpDj4Frp54aD5NDOa+ebilw89+PUxFsTuX/b6Wf4gvn7ORFbs5L5/ZqQBtkIfK3m+L+ThkDAxZb6LOMe+uhlHT8mkvOEiQoXDmCd8HDAn5IRRAJ0fxBZzPRAEYo6Rz68w4nXdLtxGC0Qc4WJX8LkyMBpMjtd9womFHKWcgwKwdKOQBvXmNKN23cS41HA8FJy42A9A9iVaZ7IldtisIfOccEZoIBhVjmFkB3XfLeRxiJYAz3ggbBJ4DloC5GJUOjYPuc1uqKAMQKDBbZo3Pgk7dD1BKMR3gRyl4fznAwDfckxtbIsKsu5F6aWNr8KZgEhMCfyZIzrDTWtXDrOuQQQxNziQv2iR0QQZmBIHqxzLyWAnN4ckGykKghvmK25si/X6rH4PNKND6vurKI/6Wvx6MPyjjacodLjArkp1l3EgiospHysFD3Ir90nck5soWfe2aZ58SeIoT9Jt1aEwMHTM0nWSiWgt93n227rYbGS+fx5EyQnn+9VzULE4aNnku8GDMjiI0/rDma8Ydf75l7OWuxN19V6u02+97DEt1qvevezF6fZL8lDs5aqXbFfJU7IqovX6uarTBjoTeozYySfUoljyDdMF8RlV9usxhCq1sABYvRY/jmuWTSYMbWpUMnISIAeqDCgX+g7wzXOgALnm0l9HmIYukpVMg3wvo03/KLmruaziS+jstMtQdZraLIQS8rBPmMrRp4vRqBFsUAH+am7+XchC9jveZOMFsTQkLlbR5ajBFoF07VQq4iiZeuOLdixcdCtuEDGtQ7hggkA0NF/ORy0WAa0dB1uc+RpvY4ej9ltQyBko9d3QUyF9eW3oUdGC+vR8ZkHb7HC3BB0aArEdXHaF8efR+DQS+rBNLF6CL2pYa46ta6EbBGSe0IN9cdDRERsGDxR/MtZVzRoht6tdmmxzlY+fYOxAq4dJAt3MY9DqKrnR6CiOZZaJr/K5jkeW9uMaL5s3MhnvZd6+AePAx/zEDajKFhpqqom8L+KvoHsbbTR8k67k+uO/afrG89caz8smfJLnNnaZUDHryKjp3OzqdyBPd8apLVxEyRS6hsDImgNo8muNVbYtmE/AB5iVxEUz3FHZ7wyI2mOQraayRzzsmIqrvMMEzWUUqmI0bifdyOcs4K05UZFXkvoOqpLI91EqgQbxlp7Kw9XuIKww4Ay6yC22Oh3XTQ/mk8eXiv4hD1oRNMpCKm4In0PDOhHo0zn7NBp3OhhgZypMBXa5Bi35Wi8+nm/pxadcbt4ioSfwO4CynKFm9Ypy3ukHhWhDajudaGoYj5ovDj3VKwLmHyLSaSL0bBgmhkDQKL/H0kXTEgzya9XXIAd+eyypX/tEXxxPLkejRqlXhZ9G/ZbsrnZy13AF2n5A1H7IrjEtG8uMcLVUNIlz2GABfYXnhNrdxCk1wvBV+h7zfJddDof76NvgIckfi/sik3vYMHK5zdWmMnQO68IQJbe7jxgPX16HcbqXQ9hltsMnuR/snk+1LTVYQ0rM6na6ef3BVJgntYlMqVDjEQrUh4LhZrOu0E5Pdl0FygiidnC6I6np7vvMD042R6XMQ0uHmSX8/0HH9qUJcvc+NiAz2MWgi3wXGC2wWpPNx1BjFe7A+xh2eqJY39ls4QNksRTMCzq3YmRxAuZ0iFCwpFZ7C8tgzgq1t7amXfQkRbKJHqRQG3km88qWdtaywagxYz51dCAaXNGDQyWc4AWuOfLSKps+X3q4//Y/UHmdxlHVyR/6yPPKeXRcCwx2MBQaLuIofpRDs1GLaLcb5P/kTTbffXj98B/XFo4H",
      "DEBUG_PAYLOAD_SAVED": false,
      "EE_EVENT_TYPE": "PAYLOAD",
      "EE_FORMATTER": "cavi2",
      "EE_HASH":
          "69d3c920e3dfd79f8d439ac4a4f7a81c838a7388343386e372e973d9fa123e59",
      "EE_ID": "stg_k8s_super",
      "EE_IS_ENCRYPTED": false,
      "EE_MESSAGE_ID": "7c420c3a-03ff-4e86-b156-ee02344241b7",
      "EE_MESSAGE_SEQ": 19019,
      "EE_PAYLOAD_PATH": [
        "stg_k8s_super",
        "admin_pipeline",
        "UPDATE_MONITOR_01",
        "UPDATE_MONITOR_01_INST"
      ],
      "EE_SENDER": "aixp_AyWzxm5uGFWPWGVHrZQt2TgH3xXrJzMw3Go55X4JB86Z",
      "EE_SIGN":
          "MEUCIB_eVJhEXP1CKW5LE0qPOQwvE3N7j7uBMeOfNCOGth4tAiEAvVe3tstvdMn6scyZPg9_olybjCFjnZ3LY74uxgF9kPc=",
      "EE_TIMESTAMP": "2024-03-01 10:44:05.896175",
      "EE_TIMEZONE": "UTC+2",
      "EE_TOTAL_MESSAGES": 19019,
      "EE_TZ": "Europe/Bucharest",
      "EE_VERSION": "3.29.431",
      "ID": 0,
      "ID_TAGS": [],
      "IMG_IN_PAYLOAD": false,
      "IMG_ORIG": null,
      "INITIATOR_ADDR": null,
      "INITIATOR_ID": null,
      "INSTANCE_ID": "UPDATE_MONITOR_01_INST",
      "IS_ALERT": false,
      "IS_ALERT_NEW_LOWER": false,
      "IS_ALERT_NEW_RAISE": false,
      "IS_ALERT_STATUS_CHANGED": false,
      "IS_NEW_LOWER": false,
      "IS_NEW_RAISE": false,
      "MODIFIED_BY_ADDR": "aixp_A6IrUO8pNoZrezX7UhYSjD7mAhpqt-p8wTVNHfuTzg-G",
      "MODIFIED_BY_ID": "SolisClient_SolisClient_bf2d",
      "PIPELINE": "admin_pipeline",
      "SESSION_ID": null,
      "SIGNATURE": "UPDATE_MONITOR_01",
      "STATUS": "N/A",
      "STREAM": "admin_pipeline",
      "STREAM_NAME": "admin_pipeline",
      "TAGS": "",
      "TIMESTAMP_ARRIVAL": "2024-03-01 10:44:05.366516",
      "TIMESTAMP_EXECUTION": "2024-03-01 10:44:05.832726",
      "_P_ALERT_HELPER": "A=0, N=0, CT=NA, E=A[]=0.00 vs >=0.50 ",
      "_P_ALIVE_TIME_MINS": 943.39,
      "_P_DATASET_BUILDER_USED": false,
      "_P_DEBUG_SAVE_PAYLOAD": false,
      "_P_DEMO_MODE": false,
      "_P_GRAPH_TYPE": [],
      "_P_PLUGIN_LOOP_RESOLUTION": 50,
      "_P_PLUGIN_REAL_RESOLUTION": null,
      "_P_PROCESS_DELAY": 60,
      "_P_VERSION": "0.1.0.0"
    };

    return json;
  }

  Future<void> saveJSONToFile(String data) async {
    // Convert data to JSON string
    String jsonString = jsonEncode(data);

    // Get directory where user wants to save the file
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      String filePath = '$directoryPath/data.json';

      // Save JSON to a file
      File file = File(filePath);
      await file.writeAsString(jsonString);
    }
  }

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
    return E2Listener(
      onPayload: (message) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(message);
        if (convertedMessage['IS_SUPERVISOR'] == true &&
            convertedMessage['CURRENT_NETWORK'] != null) {
          /// Key 'CURRENT_NETWORK' contains list of json that contains details about each row in the
          /// [NetmonTable()] or [NetmonTableNew()]. Basically, the records in netmon table
          /// is displayed using objects in the 'CURRENT_NETWORK' key.
          /// All payload messages received do not contain the
          /// 'CURRENT_NETWORK' key, the one that contains it is used as data for table.
          final currentNetwork =
              convertedMessage['CURRENT_NETWORK'] as Map<String, dynamic>;
          final currentNetworkMap = <String, NetmonBoxDetails>{};
          currentNetwork.forEach((key, value) {
            currentNetworkMap[key] =
                NetmonBoxDetails.fromMap(value as Map<String, dynamic>);
          });
          if (currentNetworkMap.length > 1) {
            setState(() {
              currentSupervisor = convertedMessage['EE_PAYLOAD_PATH']?[0];
              bool refreshReady = true;
              netmonStatus = currentNetworkMap;
              netmonStatusList = netmonStatus.entries
                  .map((entry) =>
                      NetmonBox(boxId: entry.key, details: entry.value))
                  .toList();

              supervisorIds = netmonStatusList
                  .where((element) =>
                      element.details.isSupervisor &&
                      element.details.working == 'ONLINE')
                  .map((e) => e.boxId)
                  .toList();
            });
          }
        } else {}
      },
      builder: (context) {
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
                  items: netmonStatusList
                      .map((e) => CommandLauncherData(
                            edgeNode: e.boxId,
                            configStartupFile: 'configStartupFile',
                          ))
                      .toList(),
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
                                        positiveActionButtonAction: () async {
                                          final json = getJsonData();
                                          String jsonString = jsonEncode(json);
                                          await saveJSONToFile(
                                            jsonString,
                                          );
                                          Navigator.pop(context);
                                        },
                                        positiveActionButtonText:
                                            "Download Json",
                                        negativeActionButtonText: "Close",
                                        title:
                                            "Config Startup file for ${item.edgeNode}",
                                        content: SizedBox(
                                            height: 500,
                                            child: SingleChildScrollView(
                                                child: SizedBox(
                                              width: double.maxFinite,
                                              child: XMLViwer(
                                                content:
                                                    jsonEncode(getJsonData()),
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
                                    editData(item: item);
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
                      CommandLauncherColumns.configStartupFile =>
                        size.width / 2.5,
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
      },
    );
  }
}
