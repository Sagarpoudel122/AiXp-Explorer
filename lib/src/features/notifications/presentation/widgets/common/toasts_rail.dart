part of notifications;

class ToastsRail extends StatefulWidget {
  const ToastsRail({
    super.key,
    required this.initialToasts,
    this.onClearAll,
    this.onInsert,
  });

  final List<Toast> initialToasts;
  final void Function(Toast)? onInsert;
  final VoidCallback? onClearAll;

  @override
  State<ToastsRail> createState() => ToastsRailState();
}

class ToastsRailState extends State<ToastsRail> {
  final GlobalKey<ToastsRailMobileState> toastsRailMobileKey = GlobalKey<ToastsRailMobileState>();
  final GlobalKey<ToastsRailDesktopState> toastsRailDesktopKey =
      GlobalKey<ToastsRailDesktopState>();
  List<Timer> timers = <Timer>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenType screenType = ScreenTypeHelper.getScreenType(context);
    return screenType.mapOrElse(
      desktop: (_) => ToastsRailDesktop(
        key: toastsRailDesktopKey,
        initialToasts: widget.initialToasts,
        onInsert: onInsert,
        onClearAll: clearAll,
      ),
      orElse: (_) => ToastsRailMobile(
        key: toastsRailMobileKey,
        initialToasts: widget.initialToasts,
        onInsert: onInsert,
        onClearAll: clearAll,
      ),
    );
  }

  void insert(Toast toast) {
    ScreenTypeHelper.getScreenType(context).mapOrElse(
      desktop: (_) => toastsRailDesktopKey.currentState?.insert(toast),
      orElse: (_) => toastsRailMobileKey.currentState?.insert(toast),
    );
  }

  void onInsert(Toast toast) {
    if (toast.dismissDelay != null) {
      timers.add(
        Timer(toast.dismissDelay!, () {
          remove(toast);
        }),
      );
    }
  }

  void clearAll() {
    for (final Timer element in timers) {
      element.cancel();
    }
    widget.onClearAll?.call();
  }

  void remove(Toast toast) {
    ScreenTypeHelper.getScreenType(context).mapOrElse(
      desktop: (_) => toastsRailDesktopKey.currentState?.remove(toast),
      orElse: (_) => toastsRailMobileKey.currentState?.remove(toast),
    );
  }
}

mixin AnimatedToastsListMixin {
  GlobalKey<AnimatedListState>? get animatedListKey;

  void insert(Toast toast) {}

  void remove(Toast toast) {}
}
