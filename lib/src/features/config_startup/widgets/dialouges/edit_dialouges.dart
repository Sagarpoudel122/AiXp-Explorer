import 'dart:convert';

import 'package:e2_explorer/src/data/constant_string_code.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

class EditDialouges extends StatefulWidget {
  const EditDialouges({super.key, required this.title});

  final String title;

  @override
  State<EditDialouges> createState() => _EditDialougesState();
}

class _EditDialougesState extends State<EditDialouges> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return AppDialogWidget(
      appDialogType: AppDialogType.medium,
      positiveActionButtonText: "Save",
      negativeActionButtonText: "Close",
      title: "Config Startup file for ${widget.title}",
      content: SizedBox(
        height: 360,
        width: 902,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...buildTextFields(jsonData),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTextFields(Map<String, dynamic> data,
      {String prefix = '', Color textColor = Colors.white}) {
    List<Widget> textFields = [];

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

  List<Color> colors = [Colors.white, Colors.blue, Colors.green, Colors.black];

  Widget getTextColor(String text) {
    List<String> texts = text.split(".");
    List<Color> colors = [
      Colors.white,
      Colors.blue,
      Colors.green
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
