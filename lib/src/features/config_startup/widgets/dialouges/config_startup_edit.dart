import 'dart:convert';

import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';

import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';

import 'package:flutter/material.dart';

const _name = 'admin_pipeline';
const _signature = 'UPDATE_MONITOR_01';
const _instanceId = 'UPDATE_MONITOR_01_INST';

class ConfigStartUpEditDialog {
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
      content: ConfigStartUpEdit(
        targetId: targetId,
      ),
    );
  }
}

class ConfigStartUpEdit extends StatefulWidget {
  final String targetId;

  const ConfigStartUpEdit({
    super.key,
    required this.targetId,
  });

  @override
  State<ConfigStartUpEdit> createState() => _ConfigStartUpEditState();
}

class _ConfigStartUpEditState extends State<ConfigStartUpEdit> {
  bool isLoading = true;
  Map<String, dynamic> data = {};

  Widget getTextColor(String text) {
    List<String> texts = text.split(".");
    List<Color> colors = [
      Colors.white,
      const Color(0xFFFFD600),
      const Color(0xFFFF2C78),
    ]; // Define colors

    List<InlineSpan> textSpans = [];

    for (int i = 0; i < texts.length; i++) {
      textSpans.add(
        TextSpan(
          text: texts[i],
          style: TextStyles.body(
            color: i == 0
                ? Colors.white
                : colors[(i - 1) % (colors.length - 1) + 1],
          ),
        ),
      );
      if (i != texts.length - 1) {
        textSpans.add(
          TextSpan(
              text: ".",
              style: TextStyles.body(
                color: i == 0
                    ? Colors.white
                    : colors[(i - 1) % (colors.length - 1) + 1],
              )),
        );
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }

  List<Widget> buildTextFields(Map<String, dynamic> data,
      {String prefix = '', Color textColor = Colors.white}) {
    List<Widget> textFields = [];

    Map<String, dynamic> newJson = data;

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        // If the value is a nested map, recursively build text fields
        textFields.addAll(buildTextFields(value, prefix: '$prefix$key.'));
      } else {
        textFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              getTextColor(prefix.isNotEmpty ? '$prefix$key' : key),
              const SizedBox(height: 10),
              if (value is bool)
                CustomDropDown<bool>(
                  onChanged: (value) {
                    String editedKey = prefix.isNotEmpty ? '$prefix$key' : key;
                    newJson[editedKey] = value;
                    data = newJson;
                    setState(() {});
                  },
                  value: value,
                  controller: TextEditingController(text: value.toString()),
                  hintText: "Select Option",
                  dropDownItems: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text("True"),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text("False"),
                    ),
                  ],
                )
              else
                TextField(
                  onChanged: (value) {
                    String editedKey = prefix.isNotEmpty ? '$prefix$key' : key;
                    newJson[editedKey] = value;
                    data = newJson;
                    setState(() {});
                  },
                  decoration: const InputDecoration(),
                  controller: TextEditingController(text: value.toString()),
                ),
            ],
          ),
        );
      }
    });

    return textFields;
  }

  void save() {
    try {
      data['_P_VERSION'] = '0.1.0.0.1';

      final jsonEncoded = jsonEncode(data);
      final base64Encoded = base64.encode(utf8.encode(jsonEncoded));
      E2Client().session.sendCommand(
            ActionCommands.updatePipelineInstance(
              targetId: widget.targetId,
              payload: E2InstanceConfig(instanceConfig: {
                "COMMAND": "SAVE_CONFIG",
                "DATA": base64Encoded
              }, instanceId: _instanceId, name: _name, signature: _signature),
              initiatorId: kAIXpWallet?.initiatorId,
            ),
          );
      debugPrint(' saved data: $base64Encoded');

      Navigator.of(context).pop();
    } catch (e) {
      // Handle errors, such as invalid JSON or encoding failures
      debugPrint('Error saving data: $e');
      // Optionally, you could show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return E2Listener(
      onPayload: (data) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(data);
        final EE_PAYLOAD_PATH = (convertedMessage['EE_PAYLOAD_PATH'] as List)
            .map((e) => e as String?)
            .toList();
        if (EE_PAYLOAD_PATH.length == 4) {
          if (EE_PAYLOAD_PATH[0] == widget.targetId &&
              EE_PAYLOAD_PATH[1] == _name &&
              EE_PAYLOAD_PATH[2] == _signature &&
              EE_PAYLOAD_PATH[3] == _instanceId) {
            convertedMessage.removeWhere((key, value) => value == null);
            this.data = convertedMessage;
            isLoading = false;
            setState(() {});
          }
        }
      },
      builder: (context) {
        return AppDialogWidget(
          appDialogType: AppDialogType.medium,
          positiveActionButtonText: "Save",
          negativeActionButtonText: "Close",
          positiveActionButtonAction: () {
            save();
          },
          title: "Config Startup file for ${widget.targetId}",
          content: LoadingParentWidget(
            isLoading: isLoading,
            child: SizedBox(
              height: 360,
              width: 902,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...buildTextFields(data),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
