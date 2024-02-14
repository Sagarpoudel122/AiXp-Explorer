import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  ThemeData get defaultTheme;

  Color get primaryColor;

  Color get secondaryColor;

  BoxDecoration get boxDecorations;
}

base class DarkAppTheme extends AppTheme {
  @override
  BoxDecoration get boxDecorations => throw UnimplementedError();

  @override
  ThemeData get defaultTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: ColorStyles.primaryColor,
          secondary: ColorStyles.secondaryColor,
          background: ColorStyles.primaryColor,
          error: ColorStyles.warningRed,
          onBackground: ColorStyles.secondaryColor,
          onError: ColorStyles.warningRed,
        ),
        primaryColor: ColorStyles.primaryColor,
        scaffoldBackgroundColor: ColorStyles.primaryColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 36,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
        ),
      );

  @override
  Color get primaryColor => ColorStyles.primaryColor;

  @override
  Color get secondaryColor => ColorStyles.secondaryColor;
}
