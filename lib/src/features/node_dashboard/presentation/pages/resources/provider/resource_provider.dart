import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResourceProvider extends ChangeNotifier {
  final _signature = 'NET_MON_01';
  final _name = "admin_pipeline";
  final _instanceId = "NET_MON_01_INST";
  bool isLoading = true;
  late NodeHistoryModel nodeHistoryModel;
  final _client = E2Client();

  void toggleLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void nodeHistoryCommand({required String node}) {
    toggleLoading(true);
    _client.session.sendCommand(
      ActionCommands.updatePipelineInstance(
        targetId: node,
        payload: E2InstanceConfig(
            name: 'admin_pipeline',
            signature: 'NET_MON_01',
            instanceId: 'NET_MON_01_INST',
            instanceConfig: {
              "INSTANCE_COMMAND": {"node": node, "request": "history"}
            }),
        initiatorId: kAIXpWallet?.initiatorId,
      ),
    );
  }

  Future<void> getResources({
    required Map<String, dynamic> convertedMessage,
    required String boxName,
  }) async {
    final eePayloadPath = (convertedMessage['EE_PAYLOAD_PATH'] as List)
        .map((e) => e as String?)
        .toList();
    if (eePayloadPath.length == 4) {
      if (eePayloadPath[0] == boxName &&
          eePayloadPath[1] == _name &&
          eePayloadPath[2] == _signature &&
          eePayloadPath[3] == _instanceId) {
        toggleLoading(true);

        convertedMessage.removeWhere((key, value) => value == null);
        nodeHistoryModel = NodeHistoryModel.fromJson(convertedMessage);
        toggleLoading(false);
        notifyListeners();
      }
    }
  }
}

final resourceProvider = ResourceProvider();
