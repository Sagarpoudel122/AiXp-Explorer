import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../styles/color_styles.dart';

class MyLineChart extends StatelessWidget {
  const MyLineChart({
    super.key,
    required this.borderColor,
    required this.gradient,
    required this.title,
  });

  final Color borderColor;
  final Gradient? gradient;
  final String title;

  LineChartBarData get finalData => LineChartBarData(
        isCurved: true,
        color: borderColor,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        showingIndicators: [0, 2, 3],
        belowBarData: BarAreaData(
          show: true,

          /// vertical line from top to bottom in each data points.
          // spotsLine: BarAreaSpotsLine(
          //   show: true,
          //   checkToShowSpotLine: (FlSpot spot) {
          //     var d = spot.x;
          //     print(d);
          //     return true;
          //   },
          //   flLineStyle: FlLine(
          //     color: const Color(0xFFBEC3E1).withOpacity(0.7),
          //     dashArray: [3, 3],
          //     strokeWidth: 0.9,
          //   ),
          // ),
          gradient: gradient,
        ),
        spots: const [
          FlSpot(-1, 1),
          FlSpot(0, 1.0),
          FlSpot(1, 1.4),
          FlSpot(3, 2.8),
          FlSpot(4, 1.7),
          FlSpot(5, 2.8),
          FlSpot(6, 2.6),
          FlSpot(7, 3.5),
          FlSpot(9, 2),
          FlSpot(10, 3),
          FlSpot(12, 3),
        ],
      );

  LineChartData get sampleData2 => LineChartData(
        backgroundColor: AppColors.containerBgColor,
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 10,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData2 => const LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.white,
      ));

  FlGridData get gridData => const FlGridData(show: false);

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color(0xFFb6b6b6),
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('8:00', style: style);
        break;
      case 2:
        text = const Text('8:30', style: style);
        break;
      case 3:
        text = const Text('9:00', style: style);
        break;
      case 4:
        text = const Text('9:30', style: style);
        break;
      case 5:
        text = const Text('10:00', style: style);
        break;
      case 6:
        text = const Text('10:30', style: style);
        break;
      case 7:
        text = const Text('11:00', style: style);
        break;
      case 8:
        text = const Text('11:30', style: style);
        break;
      case 9:
        text = const Text('12:00', style: style);
        break;
      case 10:
        text = const Text('12:30', style: style);
        break;
      case 11:
        text = const Text('1:00', style: style);
        break;
      case 12:
        text = const Text('1:30', style: style);
        break;
      default:
        text = const Text('8:00', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  List<LineChartBarData> get lineBarsData2 => [
        finalData,
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 570,
      // height: 315,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerBgColor,
      ),
      // child: SizedBox(
        child: AspectRatio(
          aspectRatio: 1.81,
          // aspectRatio: 1.23,
        child: Stack(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 6),
                child: LineChart(
                  sampleData2,
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            ),
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
        ),
      ),
    );
  }
}
