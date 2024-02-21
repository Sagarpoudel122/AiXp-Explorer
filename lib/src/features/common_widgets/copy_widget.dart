import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextWidget extends StatelessWidget {
  const CopyTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Clipboard.setData(ClipboardData(text: text)).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Copied to Clipboard")));
      }),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.copy_outlined,
              color: AppColors.sideNavSelectedTileIndicatorColor,
            ),
            const SizedBox(width: 7),
            Text(
              "Copy",
              style: TextStyles.bodyStrong(),
            )
          ]),
    );
  }
}
