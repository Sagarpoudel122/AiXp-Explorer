import 'dart:convert';

import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/src/features/coms/coms.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/box_messages_tab_display.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/command_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/heartbeat_view.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/pipeline_screen.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/resources/resources_tab.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DebugViewer extends StatelessWidget {
  const DebugViewer({
    super.key,
    required this.boxName,
  });

  final String? boxName;

  final _signature = 'NET_MON_01';
  final _name = "admin_pipeline";
  final _instanceId = "NET_MON_01_INST";
  @override
  Widget build(BuildContext context) {
    if (boxName == null) {
      return Container(
        color: const Color(0xff161616),
        height: double.infinity,
        child: Center(
          child: Text(
            'Box not available!',
            style: TextStyles.body(),
          ),
        ),
      );
    }
    return E2Listener(
      onPayload: (data) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(data);

        final EE_PAYLOAD_PATH = (convertedMessage['EE_PAYLOAD_PATH'] as List)
            .map((e) => e as String?)
            .toList();

        if (EE_PAYLOAD_PATH.length == 4) {
          if (EE_PAYLOAD_PATH[0] == boxName &&
              EE_PAYLOAD_PATH[1] == _name &&
              EE_PAYLOAD_PATH[2] == _signature &&
              EE_PAYLOAD_PATH[3] == _instanceId) {
            // print("----resourse payload--------------");
            // print(JsonEncoder.withIndent('  ').convert(convertedMessage));
            // print("----resourse payload--------------");
            // Clipboard.setData(ClipboardData(
            //         text:
            //             JsonEncoder.withIndent('  ').convert(convertedMessage)))
            //     .then((value) => print("copied to clipboard"));
          }
        }
      },
      builder: (context) {
        return SizedBox(
          height: double.infinity,
          child: BoxMessagesTabDisplay(
            resourcesView: ResourcesTab(
              key: ValueKey('${boxName ?? ''}1'),
              boxName: boxName!,
            ),
            pipelinesView: PipeLine(
              key: ValueKey('${boxName ?? ''}2'),
              // boxName: boxName!,z
            ),
            commsView: Comms(
              key: ValueKey('${boxName ?? ''}3'),
              boxName: boxName!,
            ),
            heartBeat: HeartbeatView(
                boxName: boxName ?? '', key: ValueKey('${boxName ?? ''}4')),
            command: CommandView(boxName: boxName ?? ''),
            onTabChanged: (tab) {},
          ),
        );
      },
    );
  }
}
