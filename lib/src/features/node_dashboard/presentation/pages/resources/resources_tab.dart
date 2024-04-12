import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/resources/provider/resource_provider.dart';
import 'package:e2_explorer/src/widgets/chats_widgets/bar_graph.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ResourceProvider>(
        builder: (context, resourceProvider, child) {
      return E2Listener(
        onPayload: (payload) {
          final Map<String, dynamic> convertedMessage =
              MqttMessageEncoderDecoder.raw(payload);
          resourceProvider.getResources(
              convertedMessage: convertedMessage, boxName: widget.boxName);
        },
        builder: (context) {
          return resourceProvider.isLoading
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
                              data: resourceProvider
                                  .nodeHistoryModel.nodeHistory.gpuLoadHist
                                  .map((e) => e.toDouble())
                                  .toList(),
                              timestamps: resourceProvider
                                  .nodeHistoryModel.nodeHistory.timestamps,
                              title: 'GPU Load',
                              borderColor: AppColors.lineChartGreenBorderColor,
                              gradient: AppColors.lineChartGreenGradient,
                            ),
                          ),
                          const SizedBox(width: 34),
                          Expanded(
                            child: LineChartWidget(
                              timestamps: resourceProvider
                                  .nodeHistoryModel.nodeHistory.timestamps,
                              data: resourceProvider
                                  .nodeHistoryModel.nodeHistory.cpuHist
                                  .map((e) => e.toDouble())
                                  .toList(),
                              title: 'CPU',
                              borderColor:
                                  AppColors.lineChartMagentaBorderColor,
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
                              timestamps: resourceProvider
                                  .nodeHistoryModel.nodeHistory.timestamps,
                              data: resourceProvider
                                  .nodeHistoryModel.nodeHistory.gpuMemAvailHist
                                  .map((e) => e.toDouble())
                                  .toList(),
                              title: 'GPU Memory',
                              borderColor: AppColors.lineChartPinkBorderColor,
                              gradient: AppColors.lineChartPinkGradient,
                            ),
                          ),
                          const SizedBox(width: 34),
                          Expanded(
                            child: LineChartWidget(
                              data: resourceProvider
                                  .nodeHistoryModel.nodeHistory.memAvailHist
                                  .map((e) => e.toDouble())
                                  .toList(),
                              timestamps: resourceProvider
                                  .nodeHistoryModel.nodeHistory.timestamps,
                              title: 'RAM',
                              borderColor: AppColors.lineChartGreenBorderColor,
                              gradient: AppColors.lineChartGreenGradient,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 34),
                      Row(
                        children: [
                          Expanded(
                              child: BarChartWidget(
                            title: "Disk",
                            totalDiskSize: resourceProvider
                                .nodeHistoryModel.nodeHistory.totalDisk
                                .toDouble(),
                            totalMemorySize: resourceProvider
                                .nodeHistoryModel.nodeHistory.totalMem
                                .toDouble(),
                          )),
                          const SizedBox(width: 34),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        },
      );
    });
  }
}
