import 'dart:convert';

import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/file_utils.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommandLauncherLogViewDialouge {
  static viewLogs(BuildContext context, {required String targetId}) {
    E2Client().session.sendCommand(
          ActionCommands.fullHeartbeat(
            targetId: targetId,
            initiatorId: kAIXpWallet?.initiatorId,
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
        content: CommandLauncherLogs(
          targetId: targetId,
        ));
  }
}

class CommandLauncherLogs extends StatefulWidget {
  const CommandLauncherLogs({super.key, required this.targetId});
  final String targetId;

  @override
  State<CommandLauncherLogs> createState() => _CommandLauncherLogsState();
}

class _CommandLauncherLogsState extends State<CommandLauncherLogs> {
  bool isLoading = true;
  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    return E2Listener(
        onPayload: (message) {},
        onHeartbeat: (message) {
          final Map<String, dynamic> convertedMessage =
              MqttMessageEncoderDecoder.raw(message);
          final eePayloadPath = (convertedMessage['EE_PAYLOAD_PATH'] as List)
              .map((e) => e as String?)
              .toList();

          // To:Do - Implement the logic to display the logs
          if (convertedMessage["EE_EVENT_TYPE"] == "HEARTBEAT" &&
              eePayloadPath[0] == widget.targetId) {
            data = convertedMessage;
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context) {
          return AppDialogWidget(
              appDialogType: AppDialogType.medium,
              headerButtons: [
                AppDialogHeaderButtons(
                    icon: Icons.copy,
                    onTap: () {
                      if (!isLoading) {
                        FileUtils.saveJSONToFile(data);
                      }
                    }),
                AppDialogHeaderButtons(
                    icon: Icons.download_sharp,
                    onTap: () {
                      if (!isLoading) {
                        Clipboard.setData(ClipboardData(text: data.toString()));
                      }
                    }),
              ],
              title:
                  "Logs for ${widget.targetId} requested at ${DateTime.now().hour}:${DateTime.now().minute}",
              content: Container(
                  height: 475,
                  padding: const EdgeInsets.all(16),
                  child: LoadingParentWidget(
                    isLoading: isLoading,
                    child: SingleChildScrollView(
                      child: XMLViwer(
                        content: jsonEncode(data),
                        type: "json",
                      ),
                    ),
                  )));
        });
  }
}
