import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../styles/color_styles.dart';
import '../../../../../widgets/chats_widgets/line_chart_widget.dart';

class ResourcesTab extends StatefulWidget {
  const ResourcesTab(
      {super.key, required this.boxName, required this.nodeHistoryModel});
  final String boxName;
  final NodeHistoryModel? nodeHistoryModel;

  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  bool isLoading = false;
  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: E2Listener(
        onPayload: (payload) {
          final Map<String, dynamic> convertedMessage =
              MqttMessageEncoderDecoder.raw(payload);
          final EE_PAYLOAD_PATH = (convertedMessage['EE_PAYLOAD_PATH'] as List)
              .map((e) => e as String?)
              .toList();

          if (EE_PAYLOAD_PATH.length == 4) {
            if (EE_PAYLOAD_PATH[0] == widget.boxName &&
                EE_PAYLOAD_PATH[1] == 'admin_pipeline' &&
                EE_PAYLOAD_PATH[2] == 'NET_MON_01' &&
                EE_PAYLOAD_PATH[3] == 'NET_MON_01_INST') {
              convertedMessage.removeWhere((key, value) => value == null);
              this.data = convertedMessage;
              isLoading = false;
              setState(() {});
            }
          }
        },
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LineChartWidget(
                      data: widget.nodeHistoryModel!.nodeHistory.gpuLoadHist
                          .map((e) => e.toDouble())
                          .toList(),
                      title: 'GPU',
                      borderColor: AppColors.lineChartGreenBorderColor,
                      gradient: AppColors.lineChartGreenGradient,
                    ),
                  ),
                  const SizedBox(width: 34),
                  Expanded(
                    child: LineChartWidget(
                      data: widget.nodeHistoryModel!.nodeHistory.cpuHist,
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
                      data: widget.nodeHistoryModel!.nodeHistory.cpuHist,
                      title: 'RAM',
                      borderColor: AppColors.lineChartPinkBorderColor,
                      gradient: AppColors.lineChartPinkGradient,
                    ),
                  ),
                  const SizedBox(width: 34),
                  Expanded(
                    child: LineChartWidget(
                      data: widget.nodeHistoryModel!.nodeHistory.gpuLoadHist
                          .map((e) => e.toDouble())
                          .toList(),
                      title: 'DISK',
                      borderColor: AppColors.lineChartBlueBorderColor,
                      gradient: AppColors.lineChartBlueGradient,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
