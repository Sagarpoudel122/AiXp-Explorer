import 'package:e2_explorer/src/features/e2_status/presentation/widgets/messages/simple_message_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PluginViewer extends StatelessWidget {
  const PluginViewer({
    super.key,
    required this.heartbeatMap,
    required this.selectedPlugin,
    required this.selectedPipeline,
  });

  final Map<String, dynamic> heartbeatMap;
  final String selectedPlugin;
  final String selectedPipeline;

  @override
  Widget build(BuildContext context) {
    final activePlugins =
        (heartbeatMap['metadata']['active_plugins'] as List).map((e) => e as Map<String, dynamic>).toList();
    final selectedActivePlugin = activePlugins
        .where((element) => element['STREAM_ID'] == selectedPipeline && element['INSTANCE_ID'] == selectedPlugin);
    final configStreams =
        (heartbeatMap['metadata']['config_streams'] as List).map((e) => e as Map<String, dynamic>).toList();
    final selectedStreamMap = configStreams.firstWhere((element) => element['NAME'] == selectedPipeline);
    final selectedStreamPluginsMap =
        (selectedStreamMap['PLUGINS'] as List).map((e) => e as Map<String, dynamic>).toList();
    final selectedPluginMap =
        selectedStreamPluginsMap.firstWhere((element) => element['INSTANCES'][0]['INSTANCE_ID'] == selectedPlugin);

    final TextStyle styleForText = GoogleFonts.inter(color: Colors.white);

    return Column(
      children: [
        Text(
          selectedPluginMap['SIGNATURE'],
          style: styleForText,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: SimpleMessageViewer(
            message: selectedPluginMap['INSTANCES'][0],
          ),
        ),
      ],
    );
  }
}
