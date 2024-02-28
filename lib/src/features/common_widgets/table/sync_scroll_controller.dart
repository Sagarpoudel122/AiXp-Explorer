import 'package:flutter/cupertino.dart';

/// SyncScrollController keeps scroll controllers in sync.
class SyncScrollController {
  SyncScrollController({
    ScrollController? leadingController,
    ScrollController? bodyController,
    ScrollController? trailingController,
  })  : leadingController = leadingController ?? ScrollController(),
        bodyController = bodyController ?? ScrollController(),
        trailingController = trailingController ?? ScrollController();

  final ScrollController leadingController;
  final ScrollController bodyController;
  final ScrollController trailingController;

  ScrollController? _scrollingController;
  bool _scrollingActive = false;

  /// Returns true if reached scroll end
  bool onNotification(
      ScrollNotification notification,
      ScrollController sourceController,
      ) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sourceController;
      _scrollingActive = true;
      return false;
    }
    if (identical(_scrollingController, sourceController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return true;
      }
      if (notification is ScrollUpdateNotification) {
        for (final ScrollController controller in <ScrollController>[
          leadingController,
          bodyController,
          trailingController,
        ]) {
          if (identical(_scrollingController, controller)) {
            continue;
          }
          if (controller.positions.isEmpty) {
            continue;
          }
          final double? offset = _scrollingController?.offset;
          if (offset != null) {
            controller.jumpTo(offset);
          }
        }
      }
    }
    return false;
  }

  void animateTo(double value, {Duration? duration, Curve? curve}) {
    for (final ScrollController controller in <ScrollController>[
      leadingController,
      bodyController,
      trailingController,
    ]) {
      if (controller.positions.isEmpty) {
        return;
      }
      controller.animateTo(
        value,
        duration: duration ?? const Duration(milliseconds: 500),
        curve: curve ?? Curves.easeOut,
      );
    }
  }

  void jumpTo(double value) {
    for (final ScrollController controller in <ScrollController>[
      leadingController,
      bodyController,
      trailingController,
    ]) {
      if (controller.positions.isEmpty) {
        return;
      }
      controller.jumpTo(value);
    }
  }

  void dispose() {
    for (final ScrollController controller in <ScrollController>[
      leadingController,
      bodyController,
      trailingController,
    ]) {
      controller.dispose();
    }
  }
}
