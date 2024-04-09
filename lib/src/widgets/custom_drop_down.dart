import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.hintText,
    required this.controller,
    required this.dropDownItems,
  });
  final String hintText;
  final TextEditingController controller;
  final List<DropdownMenuItem<T>> dropDownItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.inputFieldFillColor,
      ),
      child: DropdownButton<T>(
        value: controller.text.isNotEmpty
            ? dropDownItems
                .firstWhere(
                  (item) => item.value == controller.text,
                  orElse: () => dropDownItems.first,
                )
                .value
            : null,
        onChanged: (newValue) {
          controller.text = newValue.toString();
        },
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        items: dropDownItems,
        hint: Text(
          hintText,
          style: TextStyles.body(color: AppColors.inputFieldHintTextColor),
        ),
        isExpanded: true,
        dropdownColor: AppColors.alertDialogBgColor,
        style: TextStyles.custom(
          color: AppColors.textPrimaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
