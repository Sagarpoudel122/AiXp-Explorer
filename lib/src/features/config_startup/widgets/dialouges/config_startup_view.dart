import 'dart:convert';
import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/dart_e2/utils/xpand_utils.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/file_utils.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_data_explorer/json_data_explorer.dart';
import 'package:provider/provider.dart';

const _name = 'admin_pipeline';
const _signature = 'UPDATE_MONITOR_01';
const _instanceId = 'UPDATE_MONITOR_01_INST';

class ConfigStartUpViewDialog {
  static viewConfigLog(BuildContext context, {required String targetId}) {
    E2Client().session.sendCommand(
          ActionCommands.updatePipelineInstance(
            targetId: targetId,
            payload: E2InstanceConfig(
              instanceConfig: {
                "INSTANCE_COMMAND": {"COMMAND": "GET_CONFIG"}
              },
              instanceId: _instanceId,
              name: _name,
              signature: _signature,
            ),
          ),
        );
    _showDialog(context, targetId: targetId);
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required String targetId,
  }) async {
    await showAppDialog(
      context: context,
      content: ConfigStartUpView(
        targetId: targetId,
      ),
    );
  }
}

class ConfigStartUpView extends StatefulWidget {
  final String targetId;

  const ConfigStartUpView({
    super.key,
    required this.targetId,
  });

  @override
  State<ConfigStartUpView> createState() => _ConfigStartUpViewState();
}

class _ConfigStartUpViewState extends State<ConfigStartUpView> {
  bool isLoading = true;
  Map<String, dynamic> data = {};
  final DataExplorerStore store = DataExplorerStore();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: Consumer<DataExplorerStore>(builder:
          (BuildContext context, DataExplorerStore value, Widget? child) {
        return E2Listener(
          onPayload: (data) {
            final Map<String, dynamic> convertedMessage =
                MqttMessageEncoderDecoder.raw(data);
            final EE_PAYLOAD_PATH =
                (convertedMessage['EE_PAYLOAD_PATH'] as List)
                    .map((e) => e as String?)
                    .toList();
            if (EE_PAYLOAD_PATH.length == 4) {
              if (EE_PAYLOAD_PATH[0] == widget.targetId &&
                  EE_PAYLOAD_PATH[1] == _name &&
                  EE_PAYLOAD_PATH[2] == _signature &&
                  EE_PAYLOAD_PATH[3] == _instanceId) {
                this.data = XpandUtils.decodeEncryptedGzipMessage(
                  convertedMessage['CONFIG_STARTUP'],
                );
                isLoading = false;
                print('data is very nice ${this.data}');
                value.buildNodes(this.data, areAllCollapsed: false);
                setState(() {});
              }
            }
          },
          builder: (context) {
            return AppDialogWidget(
              isActionbuttonReversed: true,
              positiveActionButtonAction: () async {
                await FileUtils.saveJSONToFile(data);
              },
              positiveActionButtonText: "Download Json",
              negativeActionButtonText: "Close",
              title: "Config Startup file for ${widget.targetId}",
              content: SizedBox(
                child: LoadingParentWidget(
                  isLoading: isLoading,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (search) {
                            value.search(search);
                          },
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: JsonDataExplorer(
                            itemSpacing: 10,
                            nodes: value.displayNodes,
                            trailingBuilder: (context, node) => node.isFocused
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      top: 6,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints:
                                            const BoxConstraints(maxHeight: 20),
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 20,
                                        ),
                                        onPressed: () => Clipboard.setData(
                                          ClipboardData(
                                            text: jsonEncode(node.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            theme: DataExplorerTheme(
                              rootKeyTextStyle: const TextStyle(
                                color: ColorStyles.light100,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              propertyKeyTextStyle: const TextStyle(
                                color: ColorStyles.light100,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              valueTextStyle: const TextStyle(
                                color: ColorStyles.yellow,
                                fontSize: 16,
                              ),
                              highlightColor:
                                  ColorStyles.primaryColor.withOpacity(.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
