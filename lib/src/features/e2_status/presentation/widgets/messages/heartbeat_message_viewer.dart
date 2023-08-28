import 'package:e2_explorer/src/features/e2_status/presentation/widgets/common/tab_display.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/messages/simple_message_viewer.dart';
import 'package:flutter/material.dart';

class HeartbeatMessageViewer extends StatelessWidget {
  const HeartbeatMessageViewer({
    super.key,
    required this.selectedMessage,
    this.selectedRawMessage,
    required this.isHeartbeatV2,
  });

  final Map<String, dynamic>? selectedMessage;
  final Map<String, dynamic>? selectedRawMessage;
  final bool isHeartbeatV2;

  @override
  Widget build(BuildContext context) {
    if (!isHeartbeatV2) {
      return SimpleMessageViewer(
        message: selectedMessage,
      );
    }
    return TabDisplay(
      tabNames: const <String>['Decoded message', 'Raw message'],
      children: <Widget>[
        SimpleMessageViewer(
          key: const ValueKey('decoded'),
          message: selectedMessage,
        ),
        SimpleMessageViewer(
          key: const ValueKey('raw'),
          message: selectedRawMessage,
        ),
        // Container(
        //   height: double.infinity,
        //   width: double.infinity,
        //   color: Colors.red,
        // ),
      ],
    );
  }
}
