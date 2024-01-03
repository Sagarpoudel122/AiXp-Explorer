import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SelectionBar extends StatelessWidget {
  const SelectionBar({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<String> onChanged;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: items
          .map(
            (e) => ButtonSegment(
              value: e,
              label: Text(
                e,
                style: TextStyles.body(),
              ),
            ),
          )
          .toList(),
      selected: {
        if (selectedItem != null) selectedItem!,
      },
      emptySelectionAllowed: true,
      multiSelectionEnabled: false,
      onSelectionChanged: (value) {
        if (value.isEmpty) {
        } else {
          onChanged.call(value.first);
        }
      },
      showSelectedIcon: false,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          const Color(0xffd8d8d8),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
