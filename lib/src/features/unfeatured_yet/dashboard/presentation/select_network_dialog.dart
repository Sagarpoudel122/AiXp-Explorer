import 'package:flutter/cupertino.dart';

import '../../../../widgets/app_dialog_widget.dart';
import '../../../../widgets/networks_listing_widget.dart';
import '../../../../widgets/text_widget.dart';

class SelectNetworkDialog extends StatelessWidget {
  const SelectNetworkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
      positiveActionButtonText: 'Add Network',
      negativeActionButtonText: 'Close',
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
