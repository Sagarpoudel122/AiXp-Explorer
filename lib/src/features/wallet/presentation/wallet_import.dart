import 'package:e2_explorer/src/features/common_widgets/buttons/clickable_button.dart';
import 'package:e2_explorer/src/features/wallet/header.dart';
import 'package:e2_explorer/src/features/wallet/widgets/stack_background.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletImport extends StatelessWidget {
  const WalletImport({super.key});

  @override
  Widget build(BuildContext context) {
    return StackWalletBackground(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            walletPageHeader(title: "Import Your Wallet"),
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
                    'PRIVATE KEY',
                    style: TextStyles.body(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please add your private key hash',
                    textAlign: TextAlign.center,
                    style: TextStyles.body(color: AppColors.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Enter your private key",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your wallet password",
                    ),
                  ),
                  const Spacer(),
                  ClickableButton(
                    onTap: () => context.goNamed(RouteNames.network),
                    text: "Unlock Wallet",
                    backgroundColor: AppColors.buttonPrimaryBgColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have a wallet? ",
                    style: TextStyles.body()
                        .copyWith(color: const Color(0xFF92A3D6))),
                InkWell(
                    onTap: () => context.goNamed(RouteNames.walletCreate),
                    child: Text(
                      "Create Wallet",
                      style: TextStyles.body().copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4E4BDE),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
