import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../table/flr_table.dart';
import 'animated_spinning_icon.dart';

class RefreshButtonWithAnimationLabels {
  final TranslateCallback refresh;
  final TranslateCallback loading;

  RefreshButtonWithAnimationLabels({
    required this.refresh,
    required this.loading,
  });
}

class RefreshButtonWithAnimation extends StatelessWidget {
  RefreshButtonWithAnimation({
    super.key,
    required this.onTap,
    required this.labels,
    this.iconData = CarbonIcons.renew,
    this.enabled = true,
    this.isLoading = false,
    this.iconSize = 16,
    Color? color,
    Color? buttonColor,
  })  : color = color ?? AppColors.textPrimaryColor,
        buttonColor = buttonColor ?? AppColors.buttonPrimaryBgColor;

  final RefreshButtonWithAnimationLabels labels;
  final VoidCallback? onTap;
  final IconData iconData;
  final bool enabled;
  final bool isLoading;

  final double iconSize;
  final Color color;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final Icon icon = Icon(
      iconData,
      size: iconSize,
      color: color,
    );

    final TextStyle textStyle = TextStyles.small14(color: color);

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 40,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                if (isLoading)
                  AnimatedSpinningIcon(
                    icon: icon,
                    duration: 2,
                  )
                else
                  icon,
                const SizedBox(width: 8),
                if (isLoading)
                  Text(
                    labels.loading(context),
                    style: textStyle,
                  )
                else
                  Text(
                    labels.refresh(context),
                    style: textStyle,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
