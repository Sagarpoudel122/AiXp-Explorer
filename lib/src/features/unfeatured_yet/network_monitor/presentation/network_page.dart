import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_primary.dart';
import 'package:e2_explorer/src/features/dashboard/presentation/widget/dashboard_body_container.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/debug_viewer.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/model/node_history_model.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/network_status_page.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/widgets/transparent_inkwell_widget.dart';
import 'package:flutter/material.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  bool isSingleNodeManager = false;
  static const _networkPageIndex = 0;
  static const _boxDetailsPageIndex = 1;
  String? selectedBoxName;
  NetmonBox? selectedBox;
  int _navIndex = _networkPageIndex;
  final _client = E2Client();
  late NodeHistoryModel nodeHistoryModel;

  nodeHistoryCommand() {
    _client.session.sendCommand(
      ActionCommands.updatePipelineInstance(
        targetId: selectedBox!.boxId,
        payload: E2InstanceConfig(
            name: 'admin_pipeline',
            signature: 'NET_MON_01',
            instanceId: 'NET_MON_01_INST',
            instanceConfig: {
              "INSTANCE_COMMAND": {
                "node": selectedBox!.boxId,
                "request": "history"
              }
            }),
        initiatorId: kAIXpWallet?.initiatorId,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _navIndex,
      children: [
        NetworkStatusPage(
          onBoxSelected: (boxName) async {
            if (E2Client().boxHasMessages(boxName.boxId)) {
              setState(() {
                selectedBoxName = boxName.boxId;
                selectedBox = boxName;
                _navIndex = _boxDetailsPageIndex;
              });
              nodeHistoryCommand();
            } else {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Warning'),
                    content: const Text(
                        'The selected box has no messages at the moment!'),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       IconButtonWithTooltip(
            //         onTap: () {
            //           setState(() {
            //             _navIndex = _networkPageIndex;
            //             selectedBoxName = null;
            //           });
            //         },
            //         icon: CarbonIcons.chevron_left,
            //         tooltipMessage: '',
            //       ),
            //       Text(
            //         'Go back',
            //         style: TextStyles.small14(),
            //       ),
            //     ],
            //   ),
            // ),
            DashboardBodyContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
              child: Row(
                children: [
                  TransparentInkwellWidget(
                    onTap: () {
                      setState(() {
                        _navIndex = _networkPageIndex;
                        selectedBoxName = null;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back,
                          size: 24, color: AppColors.textPrimaryColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        TextWidget(
                          'Monitoring Edge Node ${selectedBoxName ?? ''}',
                          style: CustomTextStyles.text16_400,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  AppButtonPrimary(
                    onPressed: () {
                      nodeHistoryCommand();
                    },
                    text: 'Refresh',
                    height: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            selectedBoxName != null
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DebugViewer(
                        boxName: selectedBoxName,
                      ),
                    ),
                  )
                : Container(),
          ],
        )
      ],
    );
  }
}
