import 'package:e2_explorer/src/data/parameter_widget_data.dart';
import 'package:e2_explorer/src/features/manager/presentation/widgets/selection_bar.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/hf_input_field.dart';
import 'package:e2_explorer/src/widgets/property_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SizedBox(
      child: Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Config startup file for ',
                  style: TextStyles.h4().copyWith(
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    PropertyTitle(
                      name: 'Main loop resolution',
                      parameterKey: 'main_loop_resolution',
                      description: 'Main loop resolution',
                      child: HSInputField(
                        hintText: 'Main loop resolution',
                      ),
                    ),
                    const Divider(),
                    SelectionBar(
                        parameterData: ParameterWidgetData(
                      label: 'Compress heartbeat',
                      description: 'Compress heartbeat',
                      parameterKey: 'compress_heartbeat',
                      initialValue: false,
                      onChanged: () {},
                    )),
                    const Divider(),
                    PropertyTitle(
                      description: 'Seconds Heartbeat',
                      name: 'Seconds Heartbeat',
                      parameterKey: 'seconds_heartbeat',
                      child: HSInputField(
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
                    const Spacer(),
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
        ),
      ),
    );
  }
}
