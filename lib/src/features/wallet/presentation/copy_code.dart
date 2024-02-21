import 'package:e2_explorer/src/features/common_widgets/buttons/clickable_button.dart';
import 'package:e2_explorer/src/features/common_widgets/copy_widget.dart';
import 'package:e2_explorer/src/features/wallet/widgets/header.dart';
import 'package:e2_explorer/src/features/wallet/widgets/stack_background.dart';
import 'package:e2_explorer/src/routes/routes.dart';

import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CopyCodeScreen extends StatelessWidget {
  const CopyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StackWalletBackground(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            walletPageHeader(title: "Create New Wallet"),
            Container(
              width: 453,
              height: 453,
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 31),
              decoration: BoxDecoration(
                  color: AppColors.containerBgColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BACKUP YOUR PRIVATE KEY',
                    style: TextStyles.body(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Backup the text below on paper or digitally and keep it somewhere safe and secure.',
                    textAlign: TextAlign.center,
                    style: TextStyles.body(color: AppColors.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 68,
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.sideNavSelectedTileIndicatorColor),
                        color: AppColors.dropdownFieldFillColor),
                    child: Text(
                      "04695096745htiewbfiwbdihfbisugeut9i4u034htoibsjdbfkvjsb dkjvbiahepjpaowjrpfewbg564",
                      textAlign: TextAlign.center,
                      style: TextStyles.body(),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const CopyTextWidget(
                      text:
                          "04695096745htiewbfiwbdihfbisugeut9i4u034htoibsjdbfkvjsb dkjvbiahepjpaowjrpfewbg564"),
                  const Spacer(),
                  ClickableButton(
                    onTap: () => context.goNamed(RouteNames.createWalletReady),
                    text: "Continue",
                    backgroundColor: AppColors.buttonPrimaryBgColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
