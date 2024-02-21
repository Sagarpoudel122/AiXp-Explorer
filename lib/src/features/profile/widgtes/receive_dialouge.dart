import 'package:e2_explorer/src/features/common_widgets/copy_widget.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:e2_explorer/src/widgets/app_dialog_widget.dart';
import 'package:flutter/cupertino.dart';

class ReceiveDialouge extends StatelessWidget {
  const ReceiveDialouge({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
      actions: const [],
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xfff65f7033).withOpacity(0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  Text(
                    "Do not send ETH or ERC20 token to this address.",
                    style: TextStyles.custom(
                        color: const Color(0xFFFF384E),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                  Text(
                    " Learn more",
                    style: TextStyles.custom(
                        fontWeight: FontWeight.w400, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "MY PUBLIC ADDRESS",
              style: TextStyles.body(color: AppColors.textTertiaryColor),
            ),
            const SizedBox(height: 6),
            Text(
              "0xD3455346456456346534v6",
              style: TextStyles.custom(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: AppColors.textSecondaryColor),
            ),
            const SizedBox(height: 32),
            const CopyTextWidget(text: "0xD3455346456456346534v6"),
            const SizedBox(height: 32),
            Image.asset(AssetUtils.getPngIconPath("qr"))
          ],
        ),
      ),
      title: 'Receive',
    );
  }
}
