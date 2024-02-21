import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget walletPageHeader({
  required String title,
}) {
  return Column(
    children: [
      SvgPicture.asset(
        AssetUtils.getSidebarIconPath(
          'brand_logo_and_text',
        ),
        fit: BoxFit.contain,
        height: 52,
      ),
      const SizedBox(height: 20),
      Text(
        title,
        style: TextStyles.h4(),
      ),
      const SizedBox(height: 20)
    ],
  );
}
