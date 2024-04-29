import 'dart:math';
import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/provider/network_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

final networkProvider = StateNotifierProvider<NetworkProvider, NetworkState>(
    (ref) => NetworkProvider());

class NetworkProvider extends StateNotifier<NetworkState> {
  NetworkProvider() : super(NetworkState.initial());

  void updateNetmonStatusList(
      {required Map<String, dynamic> convertedMessage}) {
    if (convertedMessage['IS_SUPERVISOR'] == true &&
        convertedMessage['CURRENT_NETWORK'] != null) {
      state = state.copyWith(isLoading: true);

      final currentNetwork =
          convertedMessage['CURRENT_NETWORK'] as Map<String, dynamic>;

      final currentNetworkMap = <String, NetmonBoxDetails>{};
      currentNetwork.forEach((key, value) {
        currentNetworkMap[key] =
            NetmonBoxDetails.fromMap(value as Map<String, dynamic>);
      });
      if (currentNetworkMap.length > 1) {
        state = state.copyWith(
          isLoading: false,
          currentSupervisor: convertedMessage['EE_PAYLOAD_PATH']?[0],
          refreshReady: false,
          netmonStatus: currentNetworkMap,
          netmonStatusList: currentNetworkMap.entries
              .map((entry) => NetmonBox(boxId: entry.key, details: entry.value))
              .toList(),
          supervisorIds: currentNetworkMap.entries
              .where((entry) =>
                  entry.value.isSupervisor && entry.value.working == 'ONLINE')
              .map((entry) => entry.key)
              .toList(),
        );
      }
    }
  }
}
