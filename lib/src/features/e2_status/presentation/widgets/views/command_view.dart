import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/clickable_button.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:flutter/material.dart';

class CommandView extends StatefulWidget {
  const CommandView({
    super.key,
    required this.boxName,
  });

  final String boxName;

  @override
  State<CommandView> createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  final E2Client _client = E2Client();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClickableButton(
            onTap: () {
              _client.session.sendCommand(
                ActionCommands.stop(
                  targetId: widget.boxName,
                ),
              );
            },
            text: 'Stop',
          ),
          SizedBox(
            height: 12,
          ),
          ClickableButton(
            onTap: () {
              _client.session.sendCommand(
                ActionCommands.restart(
                  targetId: widget.boxName,
                ),
              );
            },
            text: 'Restart',
          ),
          SizedBox(
            height: 12,
          ),
          E2Listener(
              onHeartbeat: (data) {},
              builder: (context) {
                return Container();
              }),
        ],
      ),
    );
  }
}
