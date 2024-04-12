import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
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
      width: 570,
      height: 315,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerBgColor,
      ),
      child: AspectRatio(
          aspectRatio: 1.81,
          child: Stack(
            children: [
              BarChart(BarChartData(
                  maxY: (totalDiskSize > totalMemorySize
                          ? totalDiskSize
                          : totalMemorySize) +
                      20,
                  minY: 0,
                  gridData: const FlGridData(
                    show: false,
                  ),
                  titlesData: const FlTitlesData(
                    show: true,
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        toY: totalDiskSize,
                        width: 25,
                        borderRadius: BorderRadius.circular(4),
                        gradient: AppColors.lineChartPinkGradient,
                      )
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        toY: totalMemorySize,
                        width: 25,
                        borderRadius: BorderRadius.circular(4),
                        gradient: AppColors.lineChartPinkGradient,
                      )
                    ])
                  ])),
              Positioned(
                top: 40,
                left: 18,
                child: TextWidget(
                  title,
                  style: CustomTextStyles.text16_600,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
