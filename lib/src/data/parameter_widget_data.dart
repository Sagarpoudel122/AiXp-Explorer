
import 'package:flutter/material.dart';

class ParameterWidgetData {
  const ParameterWidgetData({
    required this.parameterKey,
    required this.label,
    required this.description,
    required this.initialValue,
    required this.onChanged,
    this.allowedValues,
  });

  final String parameterKey;
  final String label;
  final String description;
  final VoidCallback onChanged;
  final dynamic initialValue;
  final List<dynamic>? allowedValues;
}

