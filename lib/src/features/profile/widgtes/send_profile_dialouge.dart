
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

class SendProfileDialouge extends StatelessWidget {
  const SendProfileDialouge({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogWidget(
      positiveActionButtonText: 'Next',
      negativeActionButtonText: 'Close',
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "To: Enter address"),
            ),
            const SizedBox(height: 16),
            const CustomDropDown(hintText: "Select Asets",),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: "Enter amount"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: "Address"),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xfff65f7033).withOpacity(0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              child: Row(
                children: [
                  Text(
                    "Do not send to Ethereum/ERC20 addresses.",
                    style: TextStyles.custom(
                        color: const Color(0xFFFF384E),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  Text(
                    " Learn more",
                    style: TextStyles.custom(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      title: 'Send',
    );
  }
}
