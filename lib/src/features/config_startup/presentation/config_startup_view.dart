import 'dart:convert';

import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return E2Listener(
      onNotification: (data) {
        final EE_PAYLOAD_PATH =
            (data['EE_PAYLOAD_PATH'] as List).map((e) => e as String?).toList();
        if (EE_PAYLOAD_PATH.length == 4) {
          if (EE_PAYLOAD_PATH[0] == widget.targetId &&
              EE_PAYLOAD_PATH[1] == _name &&
              EE_PAYLOAD_PATH[2] == _signature &&
              EE_PAYLOAD_PATH[3] == _instanceId) {
            this.data = data;
            isLoading = false;
            setState(() {});
          }
        }
      },
      builder: (context) {
        return AppDialogWidget(
          isActionbuttonReversed: true,
          positiveActionButtonAction: () async {
            // final json = getJsonData();
            // String jsonString = jsonEncode(json);
            // await saveJSONToFile(
            //   jsonString,
            // );
          },
          positiveActionButtonText: "Download Json",
          negativeActionButtonText: "Close",
          title: "Config Startup file for ${widget.targetId}",
          content: LoadingParentWidget(
            isLoading: isLoading,
            child: SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: XMLViwer(
                    content: jsonEncode(data),
                    type: "json",
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
