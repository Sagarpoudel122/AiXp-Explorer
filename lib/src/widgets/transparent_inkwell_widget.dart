import 'package:flutter/material.dart';

class TransparentInkwellWidget extends StatelessWidget {
  const TransparentInkwellWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.onHover,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final ValueChanged<bool>? onHover;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      borderRadius: borderRadius,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
