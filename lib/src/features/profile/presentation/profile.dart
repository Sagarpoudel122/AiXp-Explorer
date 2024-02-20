import 'package:e2_explorer/src/features/profile/widgtes/receive_dialouge.dart';
import 'package:e2_explorer/src/features/profile/widgtes/send_profile_dialouge.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/select_network_dialog.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:e2_explorer/src/widgets/app_button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorStyles.secondaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: Text("Profile"),
              ),
              const Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 363,
                      height: 424,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: "John Doe",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            obscureText: true,
                            initialValue: "John Doe",
                            decoration: InputDecoration(
                                suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0, minHeight: 0),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "Change Password",
                                    style: TextStyles.smallStrong(
                                        color: const Color(0xFFB3B1FF)),
                                  ),
                                )),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    AssetUtils.getSvgIconPath("log-out")),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyles.small14regular(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 429),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.walletInfoContainerBgColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppButtonPrimary(
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
                              AppButtonPrimary(
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
                            style: TextStyles.body(
                                color: AppColors.textTertiaryColor),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "0xD3455346bfeiurbviuerbvn",
                            style: TextStyles.bodyStrong(),
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 24),
                          Text(
                            "Your address",
                            style: TextStyles.body(
                                color: AppColors.textTertiaryColor),
                          ),
                          const SizedBox(height: 2),
                          Text(
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
                                    style: TextStyles.body(
                                        color: AppColors.textTertiaryColor),
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
                                    style: TextStyles.body(
                                        color: AppColors.textTertiaryColor),
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
                              SvgPicture.asset(
                                  AssetUtils.getSvgIconPath("ai_expand_logo")),
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
                                    style: TextStyles.body(
                                        color: AppColors.textTertiaryColor),
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
                                    style: TextStyles.body(
                                        color: AppColors.textTertiaryColor),
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
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
