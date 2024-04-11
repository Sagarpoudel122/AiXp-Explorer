import 'dart:convert';

import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/provider/network_provider.dart';
import 'package:e2_explorer/src/widgets/chats_widgets/bar_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../styles/color_styles.dart';
import '../../../../../widgets/chats_widgets/line_chart_widget.dart';

class ResourcesTab extends StatefulWidget {
  const ResourcesTab({
    super.key,
    required this.boxName,
  });
  final String boxName;
  static getResourceTab() {}
  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  bool isLoading = true;

  NodeHistoryModel? nodeHistoryModel;
  final _signature = 'NET_MON_01';
  final _name = "admin_pipeline";
  final _instanceId = "NET_MON_01_INST";
  @override
  Widget build(BuildContext context) {
    return E2Listener(
      onPayload: (payload) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(payload);
        final eePayloadPath = (convertedMessage['EE_PAYLOAD_PATH'] as List)
            .map((e) => e as String?)
            .toList();
        if (eePayloadPath.length == 4) {
          if (eePayloadPath[0] == widget.boxName &&
              eePayloadPath[1] == _name &&
              eePayloadPath[2] == _signature &&
              eePayloadPath[3] == _instanceId) {
            setState(() {
              isLoading = true;
            });
            Clipboard.setData(ClipboardData(
                text: JsonEncoder.withIndent(" ").convert(convertedMessage)));
            convertedMessage.removeWhere((key, value) => value == null);
            nodeHistoryModel = NodeHistoryModel.fromJson(convertedMessage);
            isLoading = false;
            setState(() {});
          }
        }
      },
      builder: (context) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LineChartWidget(
                            data: nodeHistoryModel?.nodeHistory.gpuLoadHist
                                    .map((e) => e.toDouble())
                                    .toList() ??
                                [],
                            timestamps:
                                nodeHistoryModel!.nodeHistory.timestamps,
                            title: 'GPU',
                            borderColor: AppColors.lineChartGreenBorderColor,
                            gradient: AppColors.lineChartGreenGradient,
                          ),
                        ),
                        const SizedBox(width: 34),
                        Expanded(
                          child: LineChartWidget(
                            timestamps:
                                nodeHistoryModel!.nodeHistory.timestamps,
                            data: nodeHistoryModel?.nodeHistory.cpuHist
                                    .map((e) => e.toDouble())
                                    .toList() ??
                                [],
                            title: 'CPU',
                            borderColor: AppColors.lineChartMagentaBorderColor,
                            gradient: AppColors.lineChartMagentaGradient,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    Row(
                      children: [
                        Expanded(
                          child: LineChartWidget(
                            timestamps:
                                nodeHistoryModel!.nodeHistory.timestamps,
                            data: nodeHistoryModel?.nodeHistory.memAvailHist
                                    .map((e) => e.toDouble())
                                    .toList() ??
                                [],
                            title: 'RAM',
                            borderColor: AppColors.lineChartPinkBorderColor,
                            gradient: AppColors.lineChartPinkGradient,
                          ),
                        ),
                        const SizedBox(width: 34),
                        Expanded(
                            child: BarChartWidget(
                          title: 'Disk',
                          totalDiskSize: nodeHistoryModel!.nodeHistory.totalDisk
                              .toDouble(),
                          totalMemorySize:
                              nodeHistoryModel!.nodeHistory.totalMem.toDouble(),
                        )),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
