part of notifications;

class ToastsRailMobile extends StatefulWidget {
  const ToastsRailMobile({
    super.key,
    required this.initialToasts,
    this.onInsert,
    this.onClearAll,
  });
  final List<Toast> initialToasts;
  final void Function(Toast)? onInsert;
  final VoidCallback? onClearAll;

  @override
  State<ToastsRailMobile> createState() => ToastsRailMobileState();
}

class ToastsRailMobileState extends State<ToastsRailMobile> with AnimatedToastsListMixin {
  final List<Toast> _toasts = <Toast>[];
  @override
  GlobalKey<AnimatedListState>? get animatedListKey => GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      widget.initialToasts.forEach(insert);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: _toasts.isNotEmpty
                  ? ToastCard(
                      key: ValueKey<Toast>(_toasts.last),
                      toast: _toasts.last,
                      onRemove: remove,
                    )
                  : const SizedBox.shrink(),
            ),
            if (_toasts.length > 1)
              Positioned(
                top: -12,
                right: -12,
                child: SizedBox.square(
                  dimension: 24,
                  child: Material(
                    color: AppColors.textPrimaryColor,
                    shape: const CircleBorder(),
                    child: Center(
                      child: Text(
                        _toasts.length.toString(),
                        style: TextStyles.small(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void insert(Toast toast) {
    _toasts.add(toast);
    if (widget.onInsert != null) {
      widget.onInsert?.call(toast);
    }
    setState(() {});
  }

  @override
  void remove(Toast toast) {
    _toasts.remove(toast);
    setState(() {});
  }
}
