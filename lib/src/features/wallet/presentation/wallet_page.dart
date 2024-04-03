import 'package:e2_explorer/src/features/common_widgets/buttons/clickable_button.dart';
import 'package:e2_explorer/src/features/wallet/widgets/header.dart';
import 'package:e2_explorer/src/features/wallet/widgets/stack_background.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StackWalletBackground(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            walletPageHeader(title: "Wallet"),
            Container(
              width: 453,
              padding:
                  const EdgeInsets.symmetric(horizontal: 42, vertical: 120),
              decoration: BoxDecoration(
                color: AppColors.containerBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CREATE KEYSTORE',
                    style: TextStyles.body(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The password will encrypt your private Key.',
                    textAlign: TextAlign.center,
                    style: TextStyles.body(color: AppColors.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ClickableButton(
                    onTap: () => context.goNamed(RouteNames.walletImport),
                    text: "Import Account",
                    backgroundColor: AppColors.buttonPrimaryBgColor,
                  ),
                  const SizedBox(height: 20),
                  ClickableButton(
                    onTap: () => context.goNamed(RouteNames.walletCreate),
                    text: "Create Account",
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
