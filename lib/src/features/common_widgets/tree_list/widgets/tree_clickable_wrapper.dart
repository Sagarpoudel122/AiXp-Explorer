import 'package:e2_explorer/src/features/common_widgets/clickable_container.dart';
import 'package:e2_explorer/src/features/common_widgets/clickable_style_helper.dart';
import 'package:e2_explorer/src/features/common_widgets/shape_utils.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class TreeClickableWrapper extends StatelessWidget {
  const TreeClickableWrapper({
    super.key,
    required this.shapeCorners,
    this.isSelected = false,
    this.height = 48,
    this.isParent = false,
    required this.onTap,
    // required this.style,
    required this.child,
  });

  final ShapeUtilsCorners shapeCorners;
  final bool isSelected;
  final double height;
  final VoidCallback onTap;
  // final ClickableStyleHelper style;
  final bool isParent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClickableContainer(
      // isCategorySelected: isCategorySelected,
      shapeCorners: shapeCorners,
      height: height,
      onTap: onTap,
      style: _getStyle(
        isSelected: isSelected,
        isParent: isParent,
      ),
      child: child,
    );
  }
}

ClickableStyleHelper _getStyle({
  required bool isSelected,
  required bool isParent,
}) {
  if (isSelected) {
    if (isParent) {
      return _parentSelectedStyle;
    } else {
      return _childSelectedStyle;
    }
  }
  return _defaultStyle;
}

const ClickableStyleHelper _defaultStyle = ClickableStyleHelper(
  defaultColor: ColorStyles.dark800,
  hoverColor: ColorStyles.darkButtonHover,
);

const ClickableStyleHelper _parentSelectedStyle = ClickableStyleHelper(
  defaultColor: ColorStyles.spaceGrey,
  hoverColor: ColorStyles.greyButtonHover,
);

const ClickableStyleHelper _childSelectedStyle = ClickableStyleHelper(
  defaultColor: ColorStyles.selectedButtonBlue,
  hoverColor: ColorStyles.selectedHoverButtonBlue,
  defaultBorderColor: ColorStyles.selectedButtonBorder,
);
