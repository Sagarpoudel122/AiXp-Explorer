import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/debug_viewer.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/table_elements/netmon_table_new.dart';
import 'package:flutter/material.dart';

class SingleNodeNetworkPage extends StatefulWidget {
  const SingleNodeNetworkPage({super.key, required this.netmonBox});
  final NetmonBox netmonBox;

  @override
  State<SingleNodeNetworkPage> createState() => _SingleNodeNetworkPageState();
}

class _SingleNodeNetworkPageState extends State<SingleNodeNetworkPage> {
  late NodeHistoryModel nodeHistoryModel;
  final _client = E2Client();

  NodeHistoryModel getNodeHistory() {
    _client.session.sendCommand(ActionCommands.updateConfig(
        targetId: "",
        payload: {
          "NAME": "admin_pipeline",
          "SIGNATURE": "NET_MON_01",
          "INSTANCE_ID": "NET_MON_01_INST",
          "INSTANCE_CONFIG": {
            "INSTANCE_COMMAND": {"node": "gts-ws", "request": "history"}
          }
        },
        initiatorId: "",
        sessionId: ""));
    NodeHistoryModel nodeHistoryModel =
        NodeHistoryModel.fromJson(dummyNodeHistoryData);
    return nodeHistoryModel;
  }

  @override
  void initState() {
    nodeHistoryModel = getNodeHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DebugViewer(
              boxName: widget.netmonBox.boxId,
              nodeHistoryModel: nodeHistoryModel,
            ),
          ),
        )
      ],
    );
  }
}
