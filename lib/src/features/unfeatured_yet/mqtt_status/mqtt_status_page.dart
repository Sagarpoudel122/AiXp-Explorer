import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MqttStatusPage extends StatefulWidget {
  const MqttStatusPage({super.key});

  @override
  State<MqttStatusPage> createState() => _MqttStatusPageState();
}

class _MqttStatusPageState extends State<MqttStatusPage> {
  bool isConnected = E2Client().isConnected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            E2Client().server.host,
            style: TextStyles.h3(),
          ),
          const SizedBox(
            height: 4,
          ),
          E2Listener(onConnectionChanged: (connectionStatus) {
            setState(() {
              isConnected = connectionStatus as bool;
            });
          }, builder: (context) {
            return Text(
              isConnected ? 'Status: Connected' : 'Status: Disconnected',
              style: TextStyles.small14(
                color: isConnected ? ColorStyles.green : ColorStyles.red,
              ),
            );
          }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
