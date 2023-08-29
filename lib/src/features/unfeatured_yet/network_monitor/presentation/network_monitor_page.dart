import 'dart:async';

import 'package:e2_explorer/dart_e2/models/netmon/netmon_box_details.dart';
import 'package:e2_explorer/dart_e2/utils/xpand_utils.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/table_elements/netmon_table_row.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/widgets/preferred_supervisor.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class NetworkMonitorPage extends StatefulWidget {
  const NetworkMonitorPage({super.key});

  @override
  State<NetworkMonitorPage> createState() => _NetworkMonitorPageState();
}

class _NetworkMonitorPageState extends State<NetworkMonitorPage> {
  final period = const Duration(seconds: 5);
  Map<String, NetmonBoxDetails> netmonStatus = {};
  bool refreshReady = true;
  String? preferredSupervisor;
  String? currentSupervisor;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) => refreshReady = true);
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return E2Listener(
      onPayload: (data) {
        final dataMap = data as Map<String, dynamic>;
        if (dataMap['data']['specificValue']['is_supervisor'] == true &&
            dataMap['data']['specificValue']['current_network'] != null) {
          final currentNetwork = dataMap['data']['specificValue']['current_network'] as Map<String, dynamic>;
          final currentNetworkMap = <String, NetmonBoxDetails>{};
          currentNetwork.forEach((key, value) {
            currentNetworkMap[key] = NetmonBoxDetails.fromMap(value as Map<String, dynamic>);
          });
          if (currentNetworkMap.length > 1) {
            setState(() {
              currentSupervisor = dataMap['EE_PAYLOAD_PATH'][0];
              refreshReady = false;
              netmonStatus = currentNetworkMap;
            });
          }
        } else {}
      },
      // dataFilter: E2ListenerFilters.acceptAll(),
      dataFilter: (data) {
        // return true;
        /// ToDO: Refactor when only supervisor nodes are sending netmon
        final dataMap = data as Map<String, dynamic>;
        if (dataMap['EE_FORMATTER'] != "cavi2") {
          return false;
        }

        /// Added a change to accept only preferredSupervisor
        if (preferredSupervisor != null && dataMap['EE_PAYLOAD_PATH'][0] != preferredSupervisor) {
          return false;
        }
        final dataField = dataMap['data'] as Map<String, dynamic>;
        final specificValueField = dataField['specificValue'] as Map<String, dynamic>;
        final isSupervisor = specificValueField['is_supervisor'] as bool?;
        return isSupervisor == true;
      },
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Network monitor',
                  style: TextStyles.h2(),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 60,
                child: PreferredSupervisor(
                  onSupervisorChanged: (String? id) {
                    setState(() {
                      preferredSupervisor = id;
                    });
                  },
                  supervisorId: preferredSupervisor,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  currentSupervisor != null ? 'Current supervisor: $currentSupervisor' : 'No supervisor',
                  style: TextStyles.body(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: ColorStyles.grey),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                    5: FlexColumnWidth(),
                    6: FlexColumnWidth(),
                    7: FlexColumnWidth(),
                    8: FlexColumnWidth(),
                    9: FlexColumnWidth(),
                  },
                  children: [
                    createNetmonHeader(),
                    ...netmonStatus.entries.map((entry) => createNetmonTableRow(entry.key, entry.value)).toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, dynamic> decodeData(String encodedData) {
    return XpandUtils.decodeEncryptedGzipMessage(encodedData);
  }
}
