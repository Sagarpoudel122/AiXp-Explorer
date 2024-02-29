import 'package:flutter/cupertino.dart';

import '../../../../../styles/color_styles.dart';
import '../../../../../widgets/chats_widgets/line_chart_widget.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({super.key,required this.boxName});
  final String boxName;

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
                  title: 'GPU',
                  borderColor: AppColors.lineChartGreenBorderColor,
                  gradient: AppColors.lineChartGreenGradient,
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: LineChartWidget(
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
                  title: 'RAM',
                  borderColor: AppColors.lineChartPinkBorderColor,
                  gradient: AppColors.lineChartPinkGradient,
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: LineChartWidget(
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
