import 'dart:convert';


import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';

import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

class EditDialouges extends StatefulWidget {

  const EditDialouges({super.key, required this.title, required this.json});

  final String title;
  final Map<String, dynamic> json;


  @override
  State<EditDialouges> createState() => _EditDialougesState();
}

class _EditDialougesState extends State<EditDialouges> {

  late Map<String, dynamic> _jsonData;
  final E2Client _client = E2Client();

  @override
  void initState() {
    _jsonData = widget.json;
    super.initState();
  }

  void save() {
    try {
      final jsonEncoded = jsonEncode(_jsonData);
      final base64Encoded = base64.encode(utf8.encode(jsonEncoded));
      _client.session.sendCommand(ActionCommands.updateConfig(
          targetId: "",
          payload: {
            "NAME": "admin_pipeline",
            "SIGNATURE": "UPDATE_MONITOR_01",
            "INSTANCE_ID": "UPDATE_MONITOR_01_INST",
            "INSTANCE_CONFIG": {
              "INSTANCE_COMMAND": {
                "COMMAND": "SAVE_CONFIG",
                "DATA": base64Encoded
              }
            }
          },
          initiatorId: "",
          sessionId: ""));
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

    return AppDialogWidget(
      appDialogType: AppDialogType.medium,
      positiveActionButtonText: "Save",
      negativeActionButtonText: "Close",

      positiveActionButtonAction: () {
        save();
      },

      title: "Config Startup file for ${widget.title}",
      content: SizedBox(
        height: 360,
        width: 902,
        child: SingleChildScrollView(
          child: Column(
            children: [

              ...buildTextFields(widget.json),

            ],
          ),
        ),
      ),
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
                    _jsonData = newJson;
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
}
