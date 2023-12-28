import 'package:flutter/material.dart';

class HFColors {
  HFColors._();

  static late Color dark950;
  static late Color dark900;
  static late Color dark850;
  static late Color dark800;
  static late Color dark750;
  static late Color dark700;
  static late Color dark650;
  static late Color dark630;
  static late Color dark600;
  static late Color grey;
  static late Color darkGrey;
  static late Color disabledGrey;
  static late Color spaceGrey;
  static late Color lightGrey;
  static late Color light100;
  static late Color light200;
  static late Color light300;
  static late Color light900;
  static late Color red;
  static late Color warningRed;
  static late Color green;
  static late Color magenta;
  static late Color darkGold;
  static late Color blue;
  static late Color yellow;
  static late Color purple;
  static late Color lightBlue;
  static late Color darkButtonHover;
  static late Color greyButtonHover;
  static late Color selectedButtonBlue;
  static late Color selectedTabBlue;
  static late Color selectedButtonBorder;
  static late Color selectedHoverButtonBlue;
  static late Color hoverBlue;
  static late Color darkBlue;
  static late Color addAiButtonColor;
  static late Color addAiButtonHoverColor;
  static late Color addAiButtonBorderColor;
  static late Color cardActionButtonForeground;
  static late Color white;

  /// added later
  static late Color buttonPrimaryColor;

  static Color? colorConvert(String color) {
    final String newColor = color.replaceAll('#', '');

    if (newColor.length == 6) {
      return Color(int.parse('0xFF$newColor'));
    } else if (newColor.length == 8) {
      return Color(int.parse('0x$newColor'));
    } else {
      return null;
    }
  }

  static String getColorString(Color color) {
    return color.value.toRadixString(16).padLeft(6, '0').substring(2);
  }

  static String getColorStringHex(Color color) {
    return '#${getColorString(color).toUpperCase()}';
  }

  static void loadLightTheme() {
    dark950 = const Color(0xffFEFEFE);
    dark900 = const Color(0xffFEFEFE);
    dark850 = const Color(0xff6F42C1);
    dark800 = const Color(0xffFFFFFF);
    // dark800 = const Color(0xffD2C4EC);
    dark750 = const Color(0xffE9E3F6);
    dark700 = const Color(0xffF1ECF9);
    dark650 = const Color(0xff2D2D2D);
    dark630 = const Color(0xff424242);
    dark600 = const Color(0xff454545);
    grey = const Color(0xff5E5E5E);
    darkGrey = const Color(0xff575757);
    disabledGrey = const Color(0xff4F4F4F);
    spaceGrey = const Color(0xff2D2D2D);
    lightGrey = const Color(0xffBDBDBD);
    light100 = const Color(0xff161616);
    light200 = const Color(0xff2D2D2D);
    light300 = const Color(0xffF1ECF9);
    light900 = const Color(0xff161616);
    red = const Color(0xffF24647);
    warningRed = const Color(0xffDF1E1E);
    green = const Color(0xff16CD3E);
    magenta = const Color(0xffF246B8);
    darkGold = const Color(0xffB5860F);
    blue = const Color(0xff3E1179);
    yellow = const Color(0xffF1C246);
    purple = const Color(0xff3E1179);
    lightBlue = const Color(0xff6C8FF3);
    darkButtonHover = const Color(0xff262626);
    greyButtonHover = const Color(0xff383838);
    selectedButtonBlue = const Color(0xff2B3970);
    selectedTabBlue = const Color(0xff3E1179);
    selectedButtonBorder = const Color(0xff3E1179);
    selectedHoverButtonBlue = const Color(0xff354A9B);
    hoverBlue = const Color(0xff193047);
    darkBlue = const Color(0xff1C2733);
    addAiButtonColor = const Color(0xff333333);
    addAiButtonHoverColor = const Color(0xff474747);
    addAiButtonBorderColor = const Color(0xff8A8A8A);
    cardActionButtonForeground = const Color(0xff8A8A8A);

    /// added later
    buttonPrimaryColor = const Color(0xFFD2C4EC);
    white = const Color(0xFFFFFFFF);
  }

  static void loadDarkTheme() {
    dark950 = const Color(0xff0D0D0D);
    dark900 = const Color(0xff1A0D2E);
    // dark900 = const Color(0xff161616);
    dark850 = const Color(0xff181818);
    dark800 = const Color(0xff1A0D2E);
    // dark800 = const Color(0xff1F1F1F);
    dark750 = const Color(0xff262626);
    // dark700 = Colors.red;
    // dashboard table border,sidebar border, input field fill color
    dark700 = const Color(0xff3E2B5F);
    // dark700 = const Color(0xff2B2B2B);
    dark650 = const Color(0xff2D2D2D);
    dark630 = const Color(0xff424242);
    // dark600 = Colors.red;
    // border color for 'Dashboard' table
    dark600 = const Color(0xff3E2B5F);
    // dark600 = const Color(0xff454545);
    grey = const Color(0xff5E5E5E);
    darkGrey = const Color(0xff575757);
    disabledGrey = const Color(0xff4F4F4F);
    spaceGrey = const Color(0xff2D2D2D);
    lightGrey = const Color(0xffBDBDBD);
    light100 = const Color(0xffF7F7F7);
    light200 = const Color(0xffB3B3B3);
    light300 = const Color(0xffF7F7F7);
    light900 = const Color(0xff8A8A8A);
    red = const Color(0xffF24646);
    warningRed = const Color(0xffDF1E1E);
    green = const Color(0xff46F26C);
    magenta = const Color(0xffF246B8);
    darkGold = const Color(0xffB5860D);
    blue = const Color(0xff466CF2);
    yellow = const Color(0xffF2C246);
    purple = const Color(0xff3F1179);
    lightBlue = const Color(0xff6C8FF3);

    darkButtonHover = const Color(0xff262626);
    greyButtonHover = const Color(0xff383838);
    selectedButtonBlue = const Color(0xff2A3A6F);
    selectedTabBlue = const Color(0xff0073E6);
    selectedButtonBorder = const Color(0xff466CF2);
    selectedHoverButtonBlue = const Color(0xff344A9B);
    hoverBlue = const Color(0xff193047);
    darkBlue = const Color(0xff1c2733);

    addAiButtonColor = const Color(0xff333333);
    addAiButtonHoverColor = const Color(0xff474747);
    addAiButtonBorderColor = const Color(0xff8A8A8A);
    cardActionButtonForeground = const Color(0xff8A8A8A);

    /// added later
    buttonPrimaryColor = const Color(0xff466CF2);
    white = const Color(0xFFFFFFFF);
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
