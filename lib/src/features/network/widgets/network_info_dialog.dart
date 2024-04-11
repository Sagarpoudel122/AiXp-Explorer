import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/connection/domain/models/mqtt_server.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class NetworkInfoDialog extends StatelessWidget {
  const NetworkInfoDialog({super.key, required this.server});
  final MqttServer server;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget('Network Info', style: CustomTextStyles.text14_400),
          const Divider(
            color: ColorStyles.grey,
            thickness: 1,
          ),
          TextWidget(
            'Name: ${server.name}',
            style: CustomTextStyles.text16_400,
          ),
          const SizedBox(height: 10),
          TextWidget(
            'Host: ${server.host}',
            style: CustomTextStyles.text14_400,
          ),
          const SizedBox(height: 10),
          TextWidget(
            'Port: ${server.port}',
            style: CustomTextStyles.text14_400,
          ),
          const SizedBox(height: 10),
          TextWidget(
            'Username: ${server.username}',
            style: CustomTextStyles.text14_400,
          ),
        ],
      ),
    );
  }
}
