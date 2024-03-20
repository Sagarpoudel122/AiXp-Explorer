import 'package:e2_explorer/src/features/coms/coms.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/box_messages_tab_display.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/pipeline_detailed_view.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/pipeline_screen.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/resources/resources_tab.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DebugViewer extends StatelessWidget {
  const DebugViewer({
    super.key,
    required this.boxName,
    required this.nodeHistoryModel,
  });

  final String? boxName;
  final NodeHistoryModel  nodeHistoryModel;

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
    return Container(
      height: double.infinity,
      child: BoxMessagesTabDisplay(
        resourcesView: ResourcesTab(
          nodeHistoryModel: nodeHistoryModel,
          key: ValueKey('${boxName ?? ''}1'),
          boxName: boxName!,
        ),
        pipelinesView: PipeLine(
          key: ValueKey('${boxName ?? ''}2'),
          // boxName: boxName!,
        ),
        commsView: Comms(
          key: ValueKey('${boxName ?? ''}3'),
          boxName: boxName!,
        ),
        onTabChanged: (tab) {},
      ),
    );
  }
}
