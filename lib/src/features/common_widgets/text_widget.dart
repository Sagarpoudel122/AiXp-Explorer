import 'package:e2_explorer/src/utils/app_config.dart';
import 'package:flutter/material.dart';

import '../../styles/color_styles.dart';

enum CustomTextStyles {
  text12_600,
  text16_400_secondary,
  text16_600,
}

class TextWidget extends StatelessWidget {
  TextWidget(
    this.text, {
    super.key,
    this.style,
    this.fontSize,
    this.fontStyle = FontStyle.normal,
    this.fontFamily = AppConfig.appFontFamily,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.letterSpacing = 0.0,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.lineHeight,
    this.decorationColor,
    this.maxLines,
    this.textOverflow,
    this.isSelectable = false,
    this.shadows,
  }) {
    getStyle();
  }

  final String text;
  final CustomTextStyles? style;
  double? fontSize;
  FontWeight fontWeight;
  Color? textColor;
  String fontFamily;
  FontStyle fontStyle;
  double letterSpacing;
  TextAlign textAlign;
  TextDecoration? textDecoration;
  double? lineHeight;
  final Color? decorationColor;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool isSelectable;
  List<Shadow>? shadows;

  getStyle() {
    switch (style) {
      case CustomTextStyles.text12_600:
        fontSize = 12;
        fontWeight = FontWeight.w600;
        textColor ??= AppColors.textPrimaryColor;
        break;

      case CustomTextStyles.text16_400_secondary:
        fontSize = 16;
        fontWeight = FontWeight.w400;
        textColor ??= AppColors.textSecondaryColor;
        break;

      case CustomTextStyles.text16_600:
        fontSize = 16;
        fontWeight = FontWeight.w600;
        textColor ??= AppColors.textPrimaryColor;
        break;

      default:
        fontSize = 14;
        textColor ??= AppColors.textPrimaryColor;
        fontWeight = FontWeight.w400;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    textStyle = TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: textColor,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      decorationColor: decorationColor,
      overflow: textOverflow,
      height: lineHeight,
      decorationThickness: 3,
      shadows: shadows,
    );

    if (isSelectable) {
      return SelectableText(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: textStyle,
      );
    } else {
      return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: textStyle,
      );
    }
  }
}
