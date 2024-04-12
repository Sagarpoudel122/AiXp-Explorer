import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';

import 'package:flutter/material.dart';

const _name = 'admin_pipeline';
const _signature = 'UPDATE_MONITOR_01';
const _instanceId = 'UPDATE_MONITOR_01_INST';

class CommandLauncherLogViewDialouge {
  static viewLogs(BuildContext context, {required String targetId}) {
    E2Client().session.sendCommand(
          ActionCommands.fullHeartbeat(
            targetId: targetId,
            initiatorId: kAIXpWallet?.initiatorId,
          ),
        );
    _showDialog(context, targetId: targetId);
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required String targetId,
  }) async {
    await showAppDialog(context: context, content: const CommandLauncherLogs());
  }
}

class CommandLauncherLogs extends StatelessWidget {
  const CommandLauncherLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
        appDialogType: AppDialogType.medium,
        headerButtons: [
          AppDialogHeaderButtons(icon: Icons.copy, onTap: () {}),
          AppDialogHeaderButtons(icon: Icons.download_sharp, onTap: () {}),
        ],
        title:
            "Logs for ${"item.edgeNode"} requested at ${DateTime.now().hour}:${DateTime.now().minute}",
        content: Container(
          height: 475,
          padding: const EdgeInsets.all(16),
          child: Text("Logs will be available in the logs section"),
        ));
  }
}
