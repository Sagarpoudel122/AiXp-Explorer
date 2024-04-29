import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/cupertino.dart';

/// A container for the body of dashboard.
class DashboardBodyContainer extends StatelessWidget {
  const DashboardBodyContainer(
      {super.key,
      required this.child,
      this.padding,
      this.bgColor = const Color(0xFF1E1D47)});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.maxFinite,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bgColor,
      ),
      child: child,
    );
  }
}
