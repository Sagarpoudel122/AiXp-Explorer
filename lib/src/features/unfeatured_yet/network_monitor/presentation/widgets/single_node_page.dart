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
  final _client = E2Client();

  @override
  void initState() {
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
            ),
          ),
        )
      ],
    );
  }
}
