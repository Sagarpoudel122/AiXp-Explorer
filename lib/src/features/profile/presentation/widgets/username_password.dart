import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProifleUsernamePasswordSection extends StatelessWidget {
  const ProifleUsernamePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Change Password",
                    style:
                        TextStyles.smallStrong(color: const Color(0xFFB3B1FF)),
                  ),
                )),
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              final isSuccess = await kAIXpWallet?.clearWallet();
              if (isSuccess ?? false) {
                context.goNamed(RouteNames.splash);
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(AssetUtils.getSvgIconPath("log-out")),
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
    );
  }
}
