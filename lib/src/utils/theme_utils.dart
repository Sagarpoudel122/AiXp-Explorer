import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeUtils {
  static const String themeKey = 'theme';

  static bool isLightTheme = false;

  static Future<void> initialize() async {
    await ThemeUtils.checkIsLightTheme();
    ThemeUtils.loadThemeColors();
  }

  static void loadThemeColors() {
    // ThemeUtils.isLightTheme
    //     ? AppColors.initialize()
    //     : AppColors.initialize();
    AppColors.initialize();
  }

  static Future<bool> checkIsLightTheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    isLightTheme = preferences.getBool(themeKey) ?? false;
    themeValueNotifier.value = isLightTheme;
    return isLightTheme;
  }

  static Future<void> setTheme(bool isLightTheme) async {
    if (ThemeUtils.isLightTheme != isLightTheme) {
      ThemeUtils.isLightTheme = isLightTheme;
      themeValueNotifier.value = isLightTheme;
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setBool(themeKey, isLightTheme);
    }
  }

  static ValueNotifier<bool> themeValueNotifier = ValueNotifier(isLightTheme);
}
