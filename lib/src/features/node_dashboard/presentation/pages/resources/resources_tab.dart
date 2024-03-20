import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../styles/color_styles.dart';
import '../../../../../widgets/chats_widgets/line_chart_widget.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab(
      {super.key, required this.boxName, required this.nodeHistoryModel});
  final String boxName;
  final NodeHistoryModel nodeHistoryModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: LineChartWidget(
                  data: nodeHistoryModel.nodeHistory.gpuLoadHist
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
                  data: nodeHistoryModel.nodeHistory.cpuHist,
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
                  data: nodeHistoryModel.nodeHistory.cpuHist,
                  title: 'RAM',
                  borderColor: AppColors.lineChartPinkBorderColor,
                  gradient: AppColors.lineChartPinkGradient,
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: LineChartWidget(
                  data: nodeHistoryModel.nodeHistory.gpuLoadHist
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
      ),
    );
  }
}
