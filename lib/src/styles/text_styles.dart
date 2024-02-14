import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/cupertino.dart';

class TextStyles {
  static TextStyle h1({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 50.50,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h2({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 37.9,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h3({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 28.4,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h4({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 21.3,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h4Bold({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 21.3,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle body({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle bodyMedium({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle bodyStrong({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
    double? letterSpacing,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
      overflow: overflow,
    );
  }

  static TextStyle small14({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle custom({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 14,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle small14regular({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle small14Strong({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: 14,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle small({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: 12,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle caption({
    Color? color = ColorStyles.dark600,
    TextDecoration? decoration,
    FontWeight fontWeight = FontWeight.w600,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: 10,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle smallStrong({
    Color? color = ColorStyles.light100,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle cardTitle({
    Color color = ColorStyles.light900,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
  }) {
    return TextStyle(
      color: color,
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: -0.02,
    );
  }
  static TextStyle sideNavTileTextStyle({required bool isSelected}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: isSelected
          ? AppColors.sideNavSelectedTileTextColor
          : AppColors.sideNavUnselectedTileTextColor,
    );
  }
}
