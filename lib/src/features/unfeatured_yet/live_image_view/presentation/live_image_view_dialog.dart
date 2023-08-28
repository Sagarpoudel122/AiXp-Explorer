import 'package:e2_explorer/src/features/e2_status/application/client_messages/payload_message.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LiveImageViewDialog extends StatelessWidget {
  const LiveImageViewDialog({
    super.key,
    required this.originalMessage,
  });

  final PayloadMessage originalMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop(null);
            },
            child: const SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
            ),
          ),
          Center(
            child: FractionallySizedBox(
              heightFactor: 0.8,
              widthFactor: 0.7,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: ColorStyles.dark800,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live image view: ',
                        style: TextStyles.body(),
                      ),
                      const SizedBox(height: 32),

                      /// ToDO: move form in different file
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
