import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:flutter/cupertino.dart';

class NetworkProvider extends ChangeNotifier {
  Map<String, dynamic>? serverData;
  bool isLoading = false;
  String? currentSupervisor;
  List<NetmonBox> netmonStatusList = [];
  List<String> supervisorIds = [];

  void toggleLoading() {
    isLoading = !isLoading;
    print("loading.......$isLoading");
    notifyListeners();
  }

  void updateData(Map<String, dynamic> newData) {
    toggleLoading();
    serverData = newData;
    toggleLoading();
  }
}
