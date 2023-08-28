import 'package:flutter/material.dart';

class ClickableStyleHelper {
  const ClickableStyleHelper({
    this.defaultColor,
    this.hoverColor,
    this.defaultBorderColor,
    this.hoverBorderColor,
  });

  final Color? defaultColor;
  final Color? hoverColor;
  final Color? defaultBorderColor;
  final Color? hoverBorderColor;

  bool get hasBorder => defaultBorderColor != null || hoverBorderColor != null;
}
