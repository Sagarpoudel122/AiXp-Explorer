import 'package:e2_explorer/src/features/e2_status/presentation/widgets/box_messages_tab_display.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/command_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/hardware_info_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/heartbeat_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/notification_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/payload_view.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/pipeline_detailed_view.dart';
import 'package:flutter/material.dart';

class DebugViewer extends StatelessWidget {
  const DebugViewer({
    super.key,
    required this.boxName,
  });

  final String boxName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff161616),
      height: double.infinity,
      child: BoxMessagesTabDisplay(
        hardwareInfoView: HardwareInfoView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        pipelinesView: PipelineDetailedView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        payloadView: PayloadView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        notificationView: NotificationView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        heartbeatView: HeartbeatView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        commandView: CommandView(
          key: ValueKey(boxName),
          boxName: boxName,
        ),
        // fullPayloadsView: FullPayloadView(
        //   key: ValueKey(boxName),
        //   boxName: boxName,
        // ),
        onTabChanged: (tab) {},
      ),
    );
  }
}
