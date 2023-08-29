import 'package:e2_explorer/src/features/common_widgets/clickable_container.dart';
import 'package:e2_explorer/src/features/common_widgets/clickable_style_helper.dart';
import 'package:e2_explorer/src/features/common_widgets/shape_utils.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

/// A Clickable Class Icon button widget that triggers an action when tapped.
class ClickableIconButton extends StatelessWidget {
  /// Creates a clickable icon button.
  const ClickableIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor = ColorStyles.light100,
    this.backgroundColor = ColorStyles.dark700,
    this.hoverColor = ColorStyles.dark600,
    this.borderColor,
    this.hoverBorderColor,
    this.hoveredIconColor = ColorStyles.light100,
    this.height = 40,
    this.width,
  });

  /// A callback function to be called when the button is tapped.
  final VoidCallback onTap;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The icon displayed on the button.
  final IconData icon;

  /// The background color of the button.
  final Color backgroundColor;

  /// The background color of the button when hovered.
  final Color hoverColor;

  /// The border color of the button.
  final Color? borderColor;

  /// The border color of the button when hovered.
  final Color? hoverBorderColor;

  /// The text color of the button.
  final Color iconColor;

  /// The text color of the button when hovered.
  final Color hoveredIconColor;

  @override
  Widget build(BuildContext context) {
    return ClickableContainer(
      height: height,
      width: width,
      shapeCorners: ShapeUtilsCorners.all,
      borderRadius: 8,
      onTap: onTap,
      childBuilder: (isHovered) {
        return Center(
          child: Icon(
            icon,
            color: isHovered ? hoveredIconColor : iconColor,
          ),
        );
      },
      style: ClickableStyleHelper(
        defaultColor: backgroundColor,
        hoverColor: hoverColor,
        hoverBorderColor: hoverBorderColor,
        defaultBorderColor: borderColor,
      ),
    );
  }
}
