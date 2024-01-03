import 'package:e2_explorer/src/features/manager/presentation/widgets/selection_bar.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/hf_input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfigStartupSettingDialog extends StatefulWidget {
  const ConfigStartupSettingDialog({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<ConfigStartupSettingDialog> createState() =>
      _ConfigStartupSettingDialogState();

  static Future<void> show(BuildContext context, String title) async {
    await showDialog(
      context: context,
      builder: (context) => ConfigStartupSettingDialog(title: title),
    );
  }
}

class _ConfigStartupSettingDialogState
    extends State<ConfigStartupSettingDialog> {
  String? selectedHeartBeat;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorStyles.dark800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            'Config startup file for ',
            style: TextStyles.h4(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: 240,
                  child: HSInputField(
                    inputFieldLabel: 'Main loop resolution',
                    hintText: 'Main loop resolution',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Compress heartbeat'),
                const SizedBox(height: 10),
                SelectionBar(
                  items: const ['Yes', 'No'],
                  selectedItem: selectedHeartBeat,
                  onChanged: (value) {
                    selectedHeartBeat = value;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 240,
                  child: HSInputField(
                    inputFieldLabel: 'Seconds Heartbeat',
                    hintText: 'Seconds Heartbeat',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 80),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save and Restart'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
