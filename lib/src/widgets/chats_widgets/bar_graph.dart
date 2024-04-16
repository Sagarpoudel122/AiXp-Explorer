import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget(
      {super.key,
      required this.totalDiskSize,
      required this.totalMemorySize,
      required this.title});
  final double totalDiskSize;
  final double totalMemorySize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18, right: 26, left: 26),
            child: TextWidget(
              title,
              style: CustomTextStyles.text16_600,
              textAlign: TextAlign.center,
            ),
          ),
          AspectRatio(
            aspectRatio: 1.87,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: BarChart(
                BarChartData(
                  maxY: (totalDiskSize > totalMemorySize
                          ? totalDiskSize
                          : totalMemorySize) +
                      30,
                  minY: 0,
                  gridData: const FlGridData(
                    show: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String title = '';
                        switch (value.toInt()) {
                          case 0:
                            title = 'Disk';
                          case 1:
                            title = "Memory";
                          default:
                            title = "";
                        }
                        return TextWidget(
                          title,
                          style: CustomTextStyles.text12_400_tertiary,
                        );
                      },
                    )),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        toY: totalDiskSize,
                        width: 25,
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.lineChartPinkBorderColor,
                      ),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        toY: totalMemorySize,
                        width: 25,
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.lineChartPinkBorderColor,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
