import 'package:e2_explorer/src/features/profile/widgtes/receive_dialouge.dart';
import 'package:e2_explorer/src/features/profile/widgtes/send_profile_dialouge.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClientInfoSection extends StatelessWidget {
  const ClientInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 429),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.walletInfoContainerBgColor),
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppButtonSecondary(
                minWidth: 134,
                text: 'Send',
                onPressed: () {
                  showAppDialog(
                    context: context,
                    content: const SendProfileDialouge(),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              AppButtonSecondary(
                minWidth: 134,
                text: 'Receive',
                onPressed: () {
                  showAppDialog(
                    context: context,
                    content: const ReceiveDialouge(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Client address",
            style: TextStyles.body(color: AppColors.textTertiaryColor),
          ),
          const SizedBox(height: 2),
          SelectableText(
            "0xD3455346bfeiurbviuerbvn",
            style: TextStyles.bodyStrong(),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          Text(
            "Your address",
            style: TextStyles.body(color: AppColors.textTertiaryColor),
          ),
          const SizedBox(height: 2),
          SelectableText(
            "0xD3455346bfeiurbviuerbvn",
            style: TextStyles.bodyStrong(),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Block",
                    style: TextStyles.body(color: AppColors.textTertiaryColor),
                  ),
                  Text(
                    "23,345,346",
                    style: TextStyles.bodyStrong(),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Peers",
                    style: TextStyles.body(color: AppColors.textTertiaryColor),
                  ),
                  Text(
                    "23,345,346",
                    style: TextStyles.bodyStrong(),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),
          Row(
            children: [
              SvgPicture.asset(AssetUtils.getSvgIconPath("ai_expand_logo")),
              const SizedBox(width: 6),
              Text(
                "AiXpand token",
                style: TextStyles.bodyStrong(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: TextStyles.body(color: AppColors.textTertiaryColor),
                  ),
                  Text(
                    "0",
                    style: TextStyles.bodyStrong(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pending",
                    style: TextStyles.body(color: AppColors.textTertiaryColor),
                  ),
                  Text(
                    "0",
                    style: TextStyles.bodyStrong(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
