import 'dart:math';

import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_primary.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/dimens.dart';
import 'buttons/app_button_secondary.dart';

enum AppDialogType { small, medium, large }

/// A generic alert dialog widget consisting of title, contents and [positive & negative]
/// action buttons
class AppDialogWidget extends StatelessWidget {
  const AppDialogWidget({
    super.key,
    required this.content,
    required this.title,
    this.positiveActionButtonText,
    this.negativeActionButtonText,
    this.positiveActionButtonAction,
    this.negativeActionButtonAction,
    this.onDialogClose,
    this.actions,
    this.isSubmitting = false,
    this.appDialogType = AppDialogType.small,
  });

  final Widget content;
  final String title;

  /// default is OK
  final String? positiveActionButtonText;

  /// default is cancel
  final String? negativeActionButtonText;
  final VoidCallback? positiveActionButtonAction;
  final VoidCallback? negativeActionButtonAction;
  final VoidCallback? onDialogClose;
  final List<Widget>? actions;
  final bool isSubmitting;
  final AppDialogType appDialogType;

  double get getWidth {
    switch (appDialogType) {
      case AppDialogType.large:
        return Dimens.alertDialogLargeWidth;

      case AppDialogType.medium:
        return Dimens.alertDialogMediumWidth;

      default:
        return Dimens.alertDialogSmallWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.alertDialogBorderRadius),
          ),
          surfaceTintColor: AppColors.alertDialogBgColor,
          backgroundColor: AppColors.alertDialogBgColor,
          contentPadding: const EdgeInsets.all(0),
          content: Builder(builder: (context) {
            final double width = MediaQuery.of(context).size.width;
            return SizedBox(
              width: min(width, getWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// title and close icon
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 6,
                      top: 7,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.alertDialogDividerColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        /// title
                        Expanded(
                          child: TextWidget(
                            title,
                            style: CustomTextStyles.text16_600,
                          ),
                        ),

                        /// close icon
                        closeButton(context)
                      ],
                    ),
                  ),

                  /// divider
                  // Container(
                  //   height: 2,
                  //   color: AppColors.alertDialogDividerColor,
                  // ),
                  const SizedBox(height: 17),

                  /// alert dialog content here
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: content,
                    ),
                  ),
                  const SizedBox(height: 34),

                  /// action buttons here
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.alertDialogDividerColor,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (actions != null)
                          ...actions!
                        else ...[
                          AppButtonSecondary(
                            minWidth: 134,
                            height: 40,
                            text: negativeActionButtonText ?? 'Cancel',
                            onPressed: () {
                              if (negativeActionButtonAction != null) {
                                negativeActionButtonAction?.call();
                              } else {
                                popIfPossible(context);
                              }
                            },
                          ),
                          const SizedBox(width: 16),
                          AppButtonPrimary(
                            minWidth: 134,
                            text: positiveActionButtonText ?? 'OK',
                            onPressed: positiveActionButtonAction,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // const SizedBox(height: 30),
                ],
              ),
            );
          }),
        ),
        if (isSubmitting)
          ColoredBox(
            color: Colors.black.withOpacity(0.6),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  InkWell closeButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      splashColor: Colors.transparent,
      onTap: () {
        popIfPossible(context);
        onDialogClose?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Icon(Icons.close, size: 18, color: AppColors.textPrimaryColor),
      ),
    );
  }

  void popIfPossible(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
