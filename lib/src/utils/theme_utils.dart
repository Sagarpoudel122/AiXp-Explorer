import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeUtils {
  static const String themeKey = 'theme';

  static bool isLightTheme = false;

  /// This method check which theme to use and initialized the colors according to the theme.
  static Future<void> initialize() async {
    await ThemeUtils.checkIsLightTheme();
    ThemeUtils.loadThemeColors();
  }

  /// Initializes/loads the colors based on light or dark theme.
  static void loadThemeColors() {
    // ThemeUtils.isLightTheme
    //     ? AppColors.initialize()
    //     : AppColors.initialize();
    AppColors.initialize();
  }

  /// Checks which theme to use based on the value stored in shared preference.
  static Future<bool> checkIsLightTheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    isLightTheme = preferences.getBool(themeKey) ?? false;
    themeValueNotifier.value = isLightTheme;
    return isLightTheme;
  }

  /// Sets the selected theme in shared preference.
  static Future<void> setTheme(bool isLightTheme) async {
    if (ThemeUtils.isLightTheme != isLightTheme) {
      ThemeUtils.isLightTheme = isLightTheme;
      themeValueNotifier.value = isLightTheme;
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool(themeKey, isLightTheme);
    }
  }

  /// A ValueNotifier that indicates if light theme is currently selected or not. It notifies its
  /// listeners whenever its value is changed indicating that the theme selection has changed.
  static ValueNotifier<bool> themeValueNotifier = ValueNotifier(isLightTheme);
}
