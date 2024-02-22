import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NetworksListingWidget extends StatelessWidget {
  const NetworksListingWidget({
    super.key,
    required this.title,
    required this.subItems,
    this.selectedItem,
  });

  final List<String> subItems;

  final String title;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ActiveStatusDot(
              isActive: selectedItem != null && subItems.contains(selectedItem),
            ),
            const SizedBox(width: 6),
            TextWidget(title, style: CustomTextStyles.text16_600),
          ],
        ),
        const SizedBox(height: 14),
        for (String item in subItems) ...[
          Row(
            children: [
              const SizedBox(width: 15),
              Container(
                width: 30,
                alignment: Alignment.topLeft,
                child: itemSelected(item)
                    ? const Icon(Icons.check_rounded, color: Color(0xFF49D688))
                    : const SizedBox(),
              ),
              TextWidget(
                item,
                style: itemSelected(item)
                    ? CustomTextStyles.text16_600
                    : CustomTextStyles.text16_400_secondary,
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  bool itemSelected(String item) =>
      selectedItem != null && selectedItem == item;
}

class ActiveStatusDot extends StatelessWidget {
  const ActiveStatusDot({
    super.key,
    required this.isActive,
    this.size = 9,
  });

  final bool isActive;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF49D688) : const Color(0xFFFF384E),
      ),
    );
  }
}
