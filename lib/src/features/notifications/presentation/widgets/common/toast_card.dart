part of notifications;

class ToastCard extends StatefulWidget {
  const ToastCard({
    super.key,
    required this.toast,
    required this.onRemove,
  });

  final void Function(Toast) onRemove;
  final Toast toast;

  @override
  State<ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<ToastCard> with TickerProviderStateMixin {
  late final AnimationController? dismissAnimationController =
      widget.toast.dismissDelay != null
          ? AnimationController(
              vsync: this,
              duration: widget.toast.dismissDelay,
            )
          : null;

  @override
  void initState() {
    super.initState();
    dismissAnimationController?.forward();
  }

  Color get color {
    switch (widget.toast.type) {
      case ToastType.info:
        return Colors.blue;
      case ToastType.warning:
        return Colors.yellow;
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      case ToastType.dev:
        return Colors.pink;
      case ToastType.http:
        return Colors.lightBlue;
    }
  }

  IconData get icon {
    switch (widget.toast.type) {
      case ToastType.info:
        return CarbonIcons.information;
      case ToastType.warning:
        return CarbonIcons.warning_alt;
      case ToastType.error:
        return CarbonIcons.warning;
      case ToastType.success:
        return CarbonIcons.checkmark_outline;
      case ToastType.dev:
        return Icons.logo_dev;
      case ToastType.http:
        return CarbonIcons.http;
    }
  }

  @override
  void dispose() {
    dismissAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: AppColors.tableBorderColor),
        // side: BorderSide(color: HFColors.dark700),
      ),
      child: InkWell(
        onTap: () {
          if (widget.toast.onTap != null) {
            widget.toast.onTap!.call();
          }
          if (widget.toast.closeOnTap) {
            widget.onRemove(widget.toast);
          }
        },
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 64,
                color: color.withOpacity(.15),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        icon,
                        color: color,
                        size: 32,
                      ),
                    ),
                    if (widget.toast.onTap != null)
                      Positioned(
                        top: 0,
                        left: 4,
                        child: Icon(
                          CarbonIcons.overflow_menu_horizontal,
                          size: 16,
                          color: color,
                        ),
                      ),
                    if (widget.toast.debug)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Text(
                          'DEBUG',
                          style: TextStyles.small().copyWith(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    if (dismissAnimationController != null)
                      Positioned.fill(
                        top: null,
                        child: AnimatedBuilder(
                          animation: dismissAnimationController!,
                          builder: (BuildContext context, _) {
                            return LinearProgressIndicator(
                              minHeight: 2,
                              color: color,
                              backgroundColor: Colors.transparent,
                              value: 1 -
                                  (DateTime.now().millisecondsSinceEpoch -
                                          widget.toast.dateTime
                                              .millisecondsSinceEpoch) /
                                      widget.toast.dismissDelay!.inMilliseconds,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        widget.toast.title,
                        style: TextStyles.small14(),
                        overflow: TextOverflow.clip,
                        maxLines: 4,
                      ),
                      if (widget.toast.subtitle != null) ...<Widget>[
                        const SizedBox(height: 4),
                        Text(
                          widget.toast.subtitle!,
                          style: TextStyles.small(),
                          overflow: TextOverflow.clip,
                          maxLines: 10,
                        ),
                      ],
                      const Spacer(),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat.Hms().add_E().format(widget.toast.dateTime),
                        style: TextStyles.small(
                          color: AppColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => widget.onRemove(widget.toast),
                icon: Icon(CarbonIcons.close, color: AppColors.textPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
