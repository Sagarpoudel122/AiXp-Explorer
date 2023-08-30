import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleTooltip extends StatelessWidget {
  const SimpleTooltip({
    super.key,
    required this.message,
    required this.child,
    this.isEnabled = true,
  });

  /// The message displayed in the tooltip
  final String? message;

  /// The child that we want to apply the tooltip to. If we hover over the child, the tooltip will appear.
  final Widget child;

  /// If [isEnabled] is false, the tooltip won't show.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (isEnabled) {
      return Tooltip(
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: const Color(0xffBDBDBD),
          fontSize: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff1F1F1F),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: const Color(0xffBDBDBD),
          ),
        ),
        message: message,
        child: child,
      );
    } else {
      return child;
    }
  }
}
