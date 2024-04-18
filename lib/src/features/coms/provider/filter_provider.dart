import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  bool isNotification = false;
  bool isPayload = false;

  void changeFilter({
    bool? isNotification,
    bool? isPayload,
  }) {
    if (isNotification != null) {
      this.isNotification = isNotification;
    }
    if (isPayload != null) {
      this.isPayload = isPayload;
    }
    notifyListeners();
  }

  bool isFilterApplied() {
    return isNotification || isPayload;
  }
}
