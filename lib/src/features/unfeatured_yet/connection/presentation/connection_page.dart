import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_primary.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/network/widgets/select_network_dialog.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/connection/data/mqtt_server_repository.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/connection/domain/models/mqtt_server.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/connection/presentation/widgets/dropdown/server_selection_dropdown.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/connection_button.dart';
import 'package:collection/collection.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  // bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _connectToDefaultServer());
  }

  Future<void> _connectToDefaultServer() async {
    final servers = await MqttServerRepository().getMqttServers();
    final initialSelectedName =
        await MqttServerRepository().getSelectedServerName();
    MqttServer? selectedServer = servers.firstWhereOrNull(
      (element) => element.name == initialSelectedName,
    );
    if (servers.isEmpty ||
        initialSelectedName == null ||
        selectedServer == null) {
      /// add new default server
      await _addDefaultServer();
      _connectToDefaultServer();
    } else {
      /// default server found, connect to it
      _connectToServer(selectedServer);
    }
  }

  Future<void> _connectToServer(MqttServer server) async {
    E2Client.changeConnectionData(server);
    final E2Client client = E2Client();
    await client.connect();
    if (client.isConnected) {
      /// ToDO set on page render

      // if (!Platform.isMacOS) appWindow.hide();
      // const newSize = Size(1400, 800);
      // appWindow.minSize = newSize;
      // appWindow.size = newSize;
      // if (!Platform.isMacOS) appWindow.show();
      if (context.mounted) {
        Future.delayed(Duration(milliseconds: 100), () {
          context.goNamed(RouteNames.network);
        });

        // context.goNamed(RouteNames.walletPage);
      }
    } else {
      setState(() {
        errorMessage = "Could not connect to the server '${server.name}' !";
      });
      print('failed to connect');
    }
  }

  Future<void> _addDefaultServer() async {
    final MqttServer defaultServer = MqttServer(
      name: 'stage',
      host: '80.96.152.121',
      port: 11883,
      username: 'rootdev',
      password: 's3cret-passw0rd',
    );
    await MqttServerRepository().addMqttServer(defaultServer);
    await MqttServerRepository().saveSelectedServerName(defaultServer.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Center(
        child: errorMessage == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(errorMessage!, style: CustomTextStyles.text16_600),
                  const SizedBox(height: 15),
                  AppButtonPrimary(
                    text: 'View Networks',
                    onPressed: () => showAppDialog(
                      context: context,
                      content: const SelectNetworkDialog(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
