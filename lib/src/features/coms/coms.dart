import 'package:e2_explorer/src/data/constant_string_code.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:flutter/material.dart';

class Comms extends StatefulWidget {
  const Comms({super.key, required this.boxName});

  final String boxName;

  @override
  State<Comms> createState() => _CommsState();
}

class _CommsState extends State<Comms> {
  get itemBuilder => null;

  int selectedIndex = 0;
  void changeImdex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listTile({
      required bool isSelected,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E2C6A) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "notifcation",
              style: TextStyles.small14regular(color: const Color(0xFFDFDFDF)),
            ),
            Text(
              "10:23:13",
              style: TextStyles.small14regular(color: const Color(0xFFDFDFDF)),
            ),
          ],
        ),
      );
    }

    // Define custom theme

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.containerBgColor,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => changeImdex(index),
                    child: listTile(
                      isSelected: index == selectedIndex,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: 26,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.containerBgColor,
              ),
              child: XMLViwer(
                content: xml,
                type: "xml",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
