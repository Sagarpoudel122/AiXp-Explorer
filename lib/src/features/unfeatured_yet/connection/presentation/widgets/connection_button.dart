import 'package:e2_explorer/src/features/common_widgets/clickable_container.dart';
import 'package:e2_explorer/src/features/common_widgets/clickable_style_helper.dart';
import 'package:e2_explorer/src/features/common_widgets/shape_utils.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableContainer(
      height: 48,
      // width: 150,
      shapeCorners: ShapeUtilsCorners.all,
      borderRadius: 8,
      onTap: onTap,
      childBuilder: (isHovered) {
        return Center(
          child: Text(
            'Connect',
            style: TextStyles.small14(
              color: isHovered ? ColorStyles.light100 : ColorStyles.dark800,
            ),
          ),
        );
      },
      style: ClickableStyleHelper(
        defaultColor: ColorStyles.green,
        hoverColor: ColorStyles.seaGreen,
        hoverBorderColor: ColorStyles.green,
        defaultBorderColor: ColorStyles.green,
      ),
    );
  }
}
