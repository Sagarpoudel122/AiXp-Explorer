part of notifications;

class ToastsRailDesktop extends StatefulWidget {
  const ToastsRailDesktop({
    super.key,
    required this.initialToasts,
    this.onInsert,
    this.onClearAll,
  });

  final List<Toast> initialToasts;
  final void Function(Toast)? onInsert;
  final VoidCallback? onClearAll;

  @override
  State<ToastsRailDesktop> createState() => ToastsRailDesktopState();
}

class ToastsRailDesktopState extends State<ToastsRailDesktop>
    with AnimatedToastsListMixin {
  final List<Toast> _toasts = <Toast>[];

  @override
  GlobalKey<AnimatedListState>? animatedListKey = GlobalKey();

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
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedSlide(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            offset: Offset(0, _toasts.length > 1 ? 0 : -1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Material(
                color: AppColors.buttonSecondaryBgColor,
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: StadiumBorder(
                  side: BorderSide(color: AppColors.buttonSecondaryBorderColor),
                ),
                child: InkWell(
                  onTap: () => widget.onClearAll?.call(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          ToastManager._labels.clearAll(context),
                          style: TextStyles.small(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 4),
                        const Icon(CarbonIcons.close, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 380,
            child: AnimatedList(
              key: animatedListKey,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              initialItemCount: _toasts.length,
              itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) =>
                  _ToastRailDesktopItem(
                toast: _toasts[index],
                onRemove: remove,
                animation: animation,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void insert(Toast toast) {
    _toasts.add(toast);
    final AnimatedListState? animatedListState = animatedListKey?.currentState;
    if (animatedListState == null) {
      return;
    }
    animatedListState.insertItem(
      _toasts.length - 1,
      duration: const Duration(milliseconds: 200),
    );
    if (widget.onInsert != null) {
      widget.onInsert?.call(toast);
    }
    setState(() {});
  }

  @override
  void remove(Toast toast) {
    final int index = _toasts.indexOf(toast);
    if (index == -1) {
      debugPrint('Item already removed');
      return;
    }
    final AnimatedListState? animatedListState = animatedListKey?.currentState;
    if (animatedListState == null) {
      return;
    }
    animatedListState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) => IgnorePointer(
        child: _ToastRailDesktopItem(
          key: ValueKey<Toast>(toast),
          toast: toast,
          onRemove: remove,
          animation: animation,
        ),
      ),
      duration: const Duration(milliseconds: 200),
    );
    _toasts.remove(toast);
    setState(() {});
  }
}

/// Animation wrapper for the [ToastCard] widget.
class _ToastRailDesktopItem extends StatelessWidget {
  const _ToastRailDesktopItem({
    super.key,
    required this.toast,
    required this.animation,
    required this.onRemove,
  });

  final Toast toast;
  final void Function(Toast) onRemove;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ToastCard(
          toast: toast,
          onRemove: onRemove,
        ),
      ),
    );
  }
}
