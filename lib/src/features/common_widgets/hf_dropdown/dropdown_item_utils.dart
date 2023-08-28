import 'package:flutter/material.dart';

class DropdownItemUtils extends StatelessWidget {
  const DropdownItemUtils({
    super.key,
    required this.child,
    this.dividerColor = const Color(0xff454545),
    this.dividerThickness = 1,
    this.dividerHeight = 1,
    this.hasDivider = false,
    this.isVisible = true,
  });

  final Widget child;
  final Color dividerColor;
  final double dividerThickness;
  final double dividerHeight;
  final bool hasDivider;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Column(
        children: <Widget>[
          child,
          if (hasDivider)
            Divider(
              color: dividerColor,
              thickness: dividerThickness,
              indent: 0,
              endIndent: 0,
              height: dividerHeight,
            ),
        ],
      ),
    );
  }
}
