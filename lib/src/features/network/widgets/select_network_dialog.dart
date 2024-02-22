import 'package:flutter/cupertino.dart';

import '../../../utils/app_utils.dart';
import '../../common_widgets/app_dialog_widget.dart';
import 'add_network_dialog_content.dart';
import 'networks_listing_widget.dart';
import '../../common_widgets/text_widget.dart';

class SelectNetworkDialog extends StatelessWidget {
  const SelectNetworkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
      positiveActionButtonText: 'Add Network',
      negativeActionButtonText: 'Close',
      positiveActionButtonAction: () async {
        Navigator.of(context).pop();
        showAppDialog(
          context: context,
          content: const AddNetworkDialogContent(),
        );
      },
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              'The default network for AiXtend transactions is Mainnet.',
              style: CustomTextStyles.text16_400_secondary,
            ),
            const SizedBox(height: 35),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetworksListingWidget(
                  title: 'Mainnet',
                  subItems: [
                    'Staging',
                    'Lavita',
                    'POG',
                    'Passaways',
                    'Replay',
                    'Space Junk',
                    'Playground',
                  ],
                  selectedItem: 'Staging',
                ),
                NetworksListingWidget(
                  title: 'Testnet',
                  subItems: [
                    'Main Chain',
                    'Subchain Demo',
                    'Replay Test',
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      title: 'Select title',
    );
  }
}
