import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/main.dart';
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
              // _client.session.sendCommandTest(
              //   {
              //     "EE_ID": "stg_super",
              //     "ACTION": "RESTART",
              //     "PAYLOAD": null,
              //     "INITIATOR_ID": "SolisClient_SolisClient_bf2d",
              //     "EE_SIGN":
              //         "MEUCIDy8on_rdrYsDMMU2uU0qZTwNkqmvyvsABq5BNDtGGd2AiEAxyNnddlIeGpxO09iPb6jSQwRfyaCwjYceLaibL7E0PU=",
              //     "EE_SENDER":
              //         "aixp_A6IrUO8pNoZrezX7UhYSjD7mAhpqt-p8wTVNHfuTzg-G",
              //     "EE_HASH":
              //         "72d07cc77b3775b30ff59b76960d3b0c43ca59315448101eca563e8df7df86d2"
              //   },
              // );
              _client.session.sendCommand(
                ActionCommands.restart(
                  targetId: widget.boxName,
                  initiatorId: kAIXpWallet?.initiatorId,
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
