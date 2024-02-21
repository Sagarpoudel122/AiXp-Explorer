import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.inputFieldFillColor,
      ),
      child: DropdownButton(
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        items: const [],
        onChanged: (value) {},
        hint: Text(
          hintText,
          style: TextStyles.body(color: AppColors.inputFieldHintTextColor),
        ),
        isExpanded: true,
        dropdownColor: AppColors.alertDialogBgColor,
        style: TextStyles.custom(
            color: AppColors.textPrimaryColor, fontWeight: FontWeight.w400),
      ),
    );
  }
}
