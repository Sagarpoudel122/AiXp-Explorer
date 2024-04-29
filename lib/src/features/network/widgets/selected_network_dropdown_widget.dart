import 'dart:math';

import 'package:e2_explorer/src/features/network/widgets/select_network_dialog.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/connection/data/mqtt_server_repository.dart';
import 'package:flutter/material.dart';

import '../../../styles/color_styles.dart';
import '../../../utils/app_utils.dart';
import '../../../widgets/transparent_inkwell_widget.dart';
import '../../common_widgets/text_widget.dart';
import 'networks_listing_widget.dart';

class SelectedNetworkDropdownWidget extends StatefulWidget {
  const SelectedNetworkDropdownWidget({super.key});

  @override
  State<SelectedNetworkDropdownWidget> createState() =>
      _SelectedNetworkDropdownWidgetState();
}

class _SelectedNetworkDropdownWidgetState
    extends State<SelectedNetworkDropdownWidget> {
  String? selectedServer;

  Future getSelectedServer() async {
    selectedServer = await MqttServerRepository().getSelectedServerName();
    setState(() {});
  }

  @override
  void initState() {
    getSelectedServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TransparentInkwellWidget(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        showAppDialog(
          context: context,
          content: const SelectNetworkDialog(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.walletInfoContainerBgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const ActiveStatusDot(isActive: true),
            const SizedBox(width: 14),
            TextWidget(
              'Mainnet | ${selectedServer ?? '...'}',
              style: CustomTextStyles.text12_600,
            ),
            const Spacer(),
            Transform.rotate(
              angle: pi / 2,
              child: Icon(
                Icons.chevron_right,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
