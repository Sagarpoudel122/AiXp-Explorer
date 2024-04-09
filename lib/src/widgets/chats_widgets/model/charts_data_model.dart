import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartDataModel {
  final String title;
  final List<FlSpot> spots;
  final List<Color> gradients;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  ChartDataModel({
    required this.title,
    required this.spots,
    required this.gradients,
    this.minX = 0,
    this.maxX = 11,
    this.minY = 0,
    this.maxY = 6,
  });
}
