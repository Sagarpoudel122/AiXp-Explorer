import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/widgets/chats_widgets/model/charts_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomCharts extends StatelessWidget {
  const CustomCharts({super.key, required this.data});

  final ChartDataModel data;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 16), // Adjust padding as needed
            child: Text(
              data.title, // Add your desired text here
              textAlign: TextAlign.center, // Align the text at the center
              style: const TextStyle(
                fontSize: 16, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Add font weight as needed
                color: Colors.white, // Add color as needed
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 25, 8, 16),
              child: LineChart(LineChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  titlesData: const FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            reservedSize: 30, showTitles: true, interval: 1),
                      )),
                  minX: 0,
                  maxX: 11,
                  minY: 0,
                  maxY: 6,
                  gridData: const FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      gradient: Gradient.lerp(
                          LinearGradient(
                            colors: data.gradients,
                          ),
                          LinearGradient(
                            colors: data.gradients,
                          ),
                          0.5),
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: data.gradients),
                      ),
                      isStrokeCapRound: true,
                      isCurved: true,
                      spots: data.spots,
                    )
                  ])),
            ),
          ),
        ],
      ),
    );
  }
}
