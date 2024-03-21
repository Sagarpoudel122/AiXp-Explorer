part of notifications;

class ToastManagerLabels {
  ToastManagerLabels({required this.clearAll});

  final TranslateCallback clearAll;
}

class ToastManager {
  factory ToastManager() {
    return _instance;
  }
  ToastManager._({required this.getNavigatorKey});

  static late final ToastManager _instance;

  final GlobalKey<ToastsRailState> toastsRailKey = GlobalKey<ToastsRailState>();
  OverlayEntry? overlayEntry;

  final GlobalKey<NavigatorState> Function() getNavigatorKey;

  static late final bool _initialized;

  static late final ToastManagerLabels _labels;

  static void initialize({
    required ToastManagerLabels labels,
    required GlobalKey<NavigatorState> Function() getNavigatorKey,
  }) {
    _labels = labels;
    _instance = ToastManager._(getNavigatorKey: getNavigatorKey);
    _initialized = true;
  }

  void add(Toast toast, {BuildContext? context}) {
    assert(_initialized == true, 'Please run ToastManager.initialize before making calls');
    var toastsRailState = toastsRailKey.currentState;
    final navigatorKey = _instance.getNavigatorKey();
    final navigatorOverlay = navigatorKey.currentState?.overlay;

    OverlayState? overlayState;
    if (context != null) {
      try {
        overlayState = Overlay.of(context);
      } catch (e) {
        overlayState = navigatorOverlay;
      }
    } else {
      overlayState = navigatorOverlay;
    }

    if (overlayState == null) {
      debugPrint('Could not show overlay');
      return;
    }

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (BuildContext context) {
        final toastsRail = ToastsRail(
          key: toastsRailKey,
          initialToasts: <Toast>[toast],
          onClearAll: onClearAll,
        );
        return toastsRail;
      });

      overlayState.insert(overlayEntry!);
    }
    toastsRailState = toastsRailKey.currentState;
    if (toastsRailState == null) {
      debugPrint('No toasts rail found');
      return;
    }
    toastsRailState.insert(toast);
  }

  void remove(Toast toast) {
    toastsRailKey.currentState?.remove(toast);
  }

  void clearAll() {
    toastsRailKey.currentState?.clearAll();
  }

  void onClearAll() {
    overlayEntry!.remove();
    overlayEntry = null;
  }
}
