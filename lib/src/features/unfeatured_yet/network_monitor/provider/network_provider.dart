import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:flutter/cupertino.dart';

class NetworkProvider extends ChangeNotifier {
  Map<String, dynamic>? serverData;
  bool isLoading = true;
  String? currentSupervisor;
  List<NetmonBox> netmonStatusList = [];
  Map<String, NetmonBoxDetails> netmonStatus = {};
  List<String> supervisorIds = [];
  bool refreshReady = true;
  void toggleLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateNetmonStatusList(
      {required Map<String, dynamic> convertedMessage}) {
    if (convertedMessage['IS_SUPERVISOR'] == true &&
        convertedMessage['CURRENT_NETWORK'] != null) {
      toggleLoading(true);

      /// Key 'CURRENT_NETWORK' contains list of json that contains details about each row in the
      /// [NetmonTable()] or [NetmonTableNew()]. Basically, the records in netmon table
      /// is displayed using objects in the 'CURRENT_NETWORK' key.
      /// All payload messages received do not contain the
      /// 'CURRENT_NETWORK' key, the one that contains it is used as data for table.
      final currentNetwork =
          convertedMessage['CURRENT_NETWORK'] as Map<String, dynamic>;

      final currentNetworkMap = <String, NetmonBoxDetails>{};
      currentNetwork.forEach((key, value) {
        currentNetworkMap[key] =
            NetmonBoxDetails.fromMap(value as Map<String, dynamic>);
      });
      if (currentNetworkMap.length > 1) {
        currentSupervisor = convertedMessage['EE_PAYLOAD_PATH']?[0];
        refreshReady = false;
        netmonStatus = currentNetworkMap;
        netmonStatusList = netmonStatus.entries
            .map((entry) => NetmonBox(boxId: entry.key, details: entry.value))
            .toList();

        supervisorIds = netmonStatusList
            .where((element) =>
                element.details.isSupervisor &&
                element.details.working == 'ONLINE')
            .map((e) => e.boxId)
            .toList();
      }
      toggleLoading(false);
    }
  }
}

final provider = NetworkProvider();
