import 'package:e2_explorer/src/features/box_viewer/presentation/box_viewer.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/payload_viewer/presentation/payload_viewer.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/widgets/navigation/left_nav_layout.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/network_monitor_page.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final E2Client client = E2Client();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.dark800,
      body: LeftNavLayout(
        pages: [
          NetworkMonitorPage(),
          BoxViewer(),
          PayloadViewer(boxName: ''),
        ],
      ),
    );
  }
}
