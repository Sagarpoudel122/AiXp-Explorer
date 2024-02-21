import 'package:e2_explorer/src/features/common_widgets/buttons/clickable_button.dart';
import 'package:e2_explorer/src/features/wallet/widgets/header.dart';
import 'package:e2_explorer/src/features/wallet/widgets/stack_background.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';

class WalletCreate extends StatefulWidget {
  const WalletCreate({super.key});

  @override
  State<WalletCreate> createState() => _WalletCreateState();
}

class _WalletCreateState extends State<WalletCreate> {
  bool isPasswordObsecure = true;

  void togglePassword() {
    setState(() {
      isPasswordObsecure = !isPasswordObsecure;
    });
  }

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
                    'CREATE ACCOUNT',
                    style: TextStyles.body(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'This password will encrypt your private key.',
                    textAlign: TextAlign.center,
                    style: TextStyles.body(color: AppColors.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Set an Username",
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    obscureText: isPasswordObsecure,
                    decoration: InputDecoration(
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () =>togglePassword(),
                          child: SvgPicture.asset(
                            AssetUtils.getSvgIconPath("eye"),
                            height: 16,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      hintText: "Set an Password",
                    ),
                  ),
                  const SizedBox(height: 31),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: true,
                          onChanged: (value) {}),
                      const SizedBox(
                        width: 2,
                      ),
                      Flexible(
                        child: Text(
                          "I understand that AiXpand cannot recover or reset my\npassword or the keystore file. I will make a backup of the keystore file / password, keep them secret, complete all wallet creation steps.",
                          style: TextStyles.small(
                              color: AppColors.textSecondaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 31),
                  ClickableButton(
                    onTap: () => context.goNamed(RouteNames.createCopyCode),
                    text: "Create a Wallet",
                    backgroundColor: AppColors.buttonPrimaryBgColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have a wallet? ",
                    style: TextStyles.body()
                        .copyWith(color: const Color(0xFF92A3D6))),
                InkWell(
                    onTap: () => context.goNamed(RouteNames.walletImport),
                    child: Text(
                      "Unlock Wallet",
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
