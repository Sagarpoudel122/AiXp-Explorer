import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_config.dart';
import 'package:e2_explorer/src/utils/dimens.dart';
import 'package:e2_explorer/src/utils/theme_utils.dart';
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

/// Todo: separate this getter into light and dark theme if we need to configure
/// any property differently in dark and light themes.
ThemeData get appTheme =>
    (ThemeUtils.isLightTheme ? ThemeData.light() : ThemeData.dark()).copyWith(
      textTheme: _textTheme,
      inputDecorationTheme: _customInputTheme,
      buttonTheme: _buttonTheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      scrollbarTheme: _scrollBarTheme,
      brightness: Brightness.light,
      cardColor: AppColors.containerBgColor,
      dialogBackgroundColor: AppColors.alertDialogBgColor,
      dividerColor: AppColors.alertDialogDividerColor,
      primaryColor: AppColors.textPrimaryColor,
      checkboxTheme: _checkboxTheme,
    );

/// text theme
TextTheme get _textTheme {
  return ThemeData.light()
      .textTheme
      .copyWith(
        displayLarge: TextStyles.h1(),
        displayMedium: TextStyles.h2(),
        displaySmall: TextStyles.h3(),
        headlineMedium: TextStyles.h4(),
        bodyLarge: TextStyles.body(),
        bodyMedium: TextStyles.bodyStrong(),
        titleMedium: TextStyles.small(),
        titleSmall: TextStyles.smallStrong(),
      )
      .apply(
        fontFamily: AppConfig.appFontFamily,
        displayColor: AppColors.textPrimaryColor,
        bodyColor: AppColors.textPrimaryColor,
      );
}

/// input field theme
InputDecorationTheme get _customInputTheme {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelStyle: TextStyles.body(),
    errorStyle: TextStyles.smallStrong(
      color: AppColors.inputFieldErrorTextColor,
    ),
    fillColor: AppColors.inputFieldFillColor,
    filled: true,
    hintStyle: TextStyles.body(color: AppColors.inputFieldHintTextColor),
    helperStyle: TextStyles.body(color: AppColors.textPrimaryColor),
    border: _inputFieldBorder(AppColors.inputFieldUnfocusedBorderColor),
    enabledBorder: _inputFieldBorder(AppColors.inputFieldUnfocusedBorderColor),
    disabledBorder: _inputFieldBorder(AppColors.inputFieldUnfocusedBorderColor),
    focusedBorder: _inputFieldBorder(AppColors.inputFieldFocusedBorderColor),
    errorBorder: _inputFieldBorder(AppColors.inputFieldErrorBorderColor),
    contentPadding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
    errorMaxLines: 4,
  );
}

/// input field borders
OutlineInputBorder _inputFieldBorder(Color borderColor) => OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: const BorderRadius.all(
        Radius.circular(Dimens.inputFieldBorderRadius),
      ),
    );

/// button themes
ButtonThemeData get _buttonTheme => ButtonThemeData(
      height: 40,
      buttonColor: AppColors.buttonPrimaryBgColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.buttonPrimaryBorderColor),
        borderRadius: BorderRadius.circular(Dimens.btnPrimaryBorderRadius),
      ),
    );

/// scroll bar theme
ScrollbarThemeData get _scrollBarTheme => ScrollbarThemeData(
      radius: const Radius.circular(Dimens.scrollbarBorderRadius),
      thumbColor: MaterialStateProperty.resolveWith(
        (states) => AppColors.scrollbarThumbColor,
      ),
      trackColor: MaterialStateProperty.resolveWith(
        (states) => AppColors.scrollbarTrackColor,
      ),
      thickness: MaterialStateProperty.resolveWith(
        (states) => Dimens.scrollbarTrackThickness,
      ),
    );

/// checkbox theme
CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) => AppColors.checkboxCheckedFillColor,
      ),
      checkColor: MaterialStateProperty.resolveWith<Color>(
        (states) => AppColors.checkboxCheckColor,
      ),
    );
