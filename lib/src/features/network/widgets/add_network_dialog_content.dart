import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/hs_input_field.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';

class AddNetworkDialogContent extends StatelessWidget {
  const AddNetworkDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
      positiveActionButtonText: 'Add Network',
      negativeActionButtonText: 'Close',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 17),
          TextWidget(
            'Lorebfnek fejbfkwejrbfvr erbvfjbvkjbekjrbvr vernbkrj',
            style: CustomTextStyles.text16_400_secondary,
          ),
          const SizedBox(height: 27),
          const TextInputFieldWidget(hintText: 'Host'),
          const SizedBox(height: 16),
          const TextInputFieldWidget(hintText: 'Port'),
          const SizedBox(height: 16),
          const TextInputFieldWidget(hintText: 'Password'),
          const SizedBox(height: 16),
          const TextInputFieldWidget(hintText: 'User'),
        ],
      ),
      title: 'Add Network',
    );
  }
}
