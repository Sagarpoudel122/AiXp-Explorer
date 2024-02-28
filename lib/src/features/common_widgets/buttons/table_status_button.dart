import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/cupertino.dart';

enum TsbStatus { success, error, warning }

class TableStatusButton extends StatelessWidget {
  const TableStatusButton({super.key, required this.text, required this.tsbStatus});

  final String text;
  final TsbStatus tsbStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: bgColor,
      ),
      child: TextWidget(
        text,
        style: CustomTextStyles.text14_400,
        textColor: textColor,
      ),
    );
  }

  Color get bgColor {
    switch (tsbStatus) {
      case TsbStatus.success:
        return AppColors.tableStatusSuccessBtnBgColor;
      case TsbStatus.error:
        return AppColors.tableStatusErrorBtnBgColor;
      case TsbStatus.warning:
        return AppColors.tableStatusWarningBtnBgColor;
    }
  }

  Color get textColor {
    switch (tsbStatus) {
      case TsbStatus.success:
        return AppColors.tableStatusSuccessBtnTextColor;
      case TsbStatus.error:
        return AppColors.tableStatusErrorBtnTextColor;
      case TsbStatus.warning:
        return AppColors.tableStatusWarningBtnTextColor;
    }
  }
}
