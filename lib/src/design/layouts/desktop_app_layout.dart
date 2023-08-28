import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/window_buttons.dart';
import 'package:flutter/material.dart';

class DesktopAppLayout extends StatelessWidget {
  const DesktopAppLayout({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WindowTitleBarBox(
          child: Row(
            children: <Widget>[
              Expanded(child: MoveWindow()),
              const WindowButtons(),
            ],
          ),
        ),
        if (child != null) Expanded(child: child!),
      ],
    );
  }
}
