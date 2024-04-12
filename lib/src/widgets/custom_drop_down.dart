import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.hintText,
    required this.controller,
    required this.dropDownItems,
    required this.onChanged,
    required this.value,
  });
  final String hintText;
  final TextEditingController controller;
  final List<DropdownMenuItem<T>> dropDownItems;
  final void Function(T?) onChanged;
  final T? value;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.inputFieldFillColor,
      ),
      child: DropdownButton<T>(
        value: widget.value,
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        items: widget.dropDownItems,
        hint: Text(
          widget.hintText,
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
