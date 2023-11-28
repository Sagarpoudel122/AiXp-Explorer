import 'package:e2_explorer/dart_e2/models/utils_models/e2_heartbeat.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PluginViewer extends StatelessWidget {
  const PluginViewer({
    super.key,
    required this.heartbeat,
    required this.selectedPlugin,
    required this.selectedPipeline,
  });

  final E2Heartbeat heartbeat;
  final String selectedPlugin;
  final String selectedPipeline;

  @override
  Widget build(BuildContext context) {
    // final activePlugins =
    //     (heartbeat.activePlugins).map((e) => e as Map<String, dynamic>).toList();
    // final selectedActivePlugin = activePlugins
    //     .where((element) => element['STREAM_ID'] == selectedPipeline && element['INSTANCE_ID'] == selectedPlugin);
    // final configStreams =
    //     (heartbeat['metadata']['config_streams'] as List).map((e) => e as Map<String, dynamic>).toList();
    // final selectedStreamMap = configStreams.firstWhere((element) => element['NAME'] == selectedPipeline);
    // final selectedStreamPluginsMap =
    //     (selectedStreamMap['PLUGINS'] as List).map((e) => e as Map<String, dynamic>).toList();
    // final selectedPluginMap =
    //     selectedStreamPluginsMap.firstWhere((element) => element['INSTANCES'][0]['INSTANCE_ID'] == selectedPlugin);

    final TextStyle styleForText = GoogleFonts.inter(color: Colors.white);

    return Center(
      child: Text(
        'Functionality disable',
        style: TextStyles.body(),
      ),
    );

    // return Column(
    //   children: [
    //     Text(
    //       selectedPluginMap['SIGNATURE'],
    //       style: styleForText,
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Expanded(
    //       child: SimpleMessageViewer(
    //         message: selectedPluginMap['INSTANCES'][0],
    //       ),
    //     ),
    //   ],
    // );
  }
}
