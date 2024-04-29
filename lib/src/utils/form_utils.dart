import 'package:flutter/cupertino.dart';

class FormUtils {
  static final RegExp _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  ///validate password
  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value == '') {
      return 'This field is required!';
      // return context.locale.this_field_is_required;
    }
    if (value.length < 6) {
      return 'Password must contain at least 6 characters!';
    }
    // if (!isPasswordValid(value)) {
    //   return 'Password invalid!';
    // }
    return null;
  }

  static bool isPasswordValid(String? value) {
    return value != null && _passwordRegex.hasMatch(value);
  }

  ///validate required field
  static String? validateRequiredField(BuildContext context, String? value) {
    if (!isRequiredFieldValid(value)) {
      return 'This field is required!';
    }
    return null;
  }

  static bool isRequiredFieldValid(String? value) {
    return value != null && value != '';
  }
}
