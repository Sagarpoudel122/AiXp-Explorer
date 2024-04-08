import 'dart:async';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/dart_e2/models/payload/netmon/netmon_box_details.dart';
import 'package:e2_explorer/dart_e2/utils/xpand_utils.dart';
import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_primary.dart';
import 'package:e2_explorer/src/features/common_widgets/hf_dropdown/overlay_utils.dart';
import 'package:e2_explorer/src/features/common_widgets/text_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/tooltip/icon_button_tooltip.dart';
import 'package:e2_explorer/src/features/dashboard/presentation/widget/dashboard_body_container.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/table_elements/netmon_table.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/table_elements/netmon_table_new.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/widgets/preferred_supervisor_menu.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/widgets/single_node_page.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NetworkStatusPage extends StatefulWidget {
  const NetworkStatusPage({
    super.key,
    required this.onBoxSelected,
  });

  final void Function(NetmonBox) onBoxSelected;

  @override
  State<NetworkStatusPage> createState() => _NetworkStatusPageState();
}

class _NetworkStatusPageState extends State<NetworkStatusPage> {
  bool isLoading = true;
  final period = const Duration(seconds: 5);
  Map<String, NetmonBoxDetails> netmonStatus = {};
  List<NetmonBox> netmonStatusList = [];
  List<String> supervisorIds = [];
  bool refreshReady = true;
  final OverlayController _settingsOverlayController =
      OverlayController('Preferred supervisor');

  // String? preferredSupervisor;
  String? currentSupervisor;
  late final Timer timer;
  bool isSingleNodeManager = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 5), (timer) => refreshReady = true);
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return E2Listener(
      onPayload: (message) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(message);

        if (convertedMessage['IS_SUPERVISOR'] == true &&
            convertedMessage['CURRENT_NETWORK'] != null) {
          setState(() {
            isLoading = true;
          });

          /// Key 'CURRENT_NETWORK' contains list of json that contains details about each row in the
          /// [NetmonTable()] or [NetmonTableNew()]. Basically, the records in netmon table
          /// is displayed using objects in the 'CURRENT_NETWORK' key.
          /// All payload messages received do not contain the
          /// 'CURRENT_NETWORK' key, the one that contains it is used as data for table.
          final currentNetwork =
              convertedMessage['CURRENT_NETWORK'] as Map<String, dynamic>;
          final currentNetworkMap = <String, NetmonBoxDetails>{};
          currentNetwork.forEach((key, value) {
            currentNetworkMap[key] =
                NetmonBoxDetails.fromMap(value as Map<String, dynamic>);
          });
          if (currentNetworkMap.length > 1) {
            setState(() {
              currentSupervisor = convertedMessage['EE_PAYLOAD_PATH']?[0];
              refreshReady = false;
              netmonStatus = currentNetworkMap;
              netmonStatusList = netmonStatus.entries
                  .map((entry) =>
                      NetmonBox(boxId: entry.key, details: entry.value))
                  .toList();

              supervisorIds = netmonStatusList
                  .where((element) =>
                      element.details.isSupervisor &&
                      element.details.working == 'ONLINE')
                  .map((e) => e.boxId)
                  .toList();
            });
          }
        } else {}
        isLoading = false;
      },
      // dataFilter: E2ListenerFilters.acceptAll(),
      dataFilter: (data) {
        // return true;
        /// ToDO: Refactor when only supervisor nodes are sending netmon
        final dataMap = data as Map<String, dynamic>;
        // if (dataMap?['EE_FORMATTER'] != "cavi2") {
        //   return false;
        // }

        /// Added a change to accept only preferredSupervisor
        if (currentSupervisor != null &&
            dataMap['EE_PAYLOAD_PATH']?[0] != currentSupervisor) {
          return false;
        }
        // final dataField = dataMap?['data'] as Map<String, dynamic>;
        // final specificValueField = dataField?['specificValue'] as Map<String, dynamic>;
        // final isSupervisor = specificValueField?['is_supervisor'] as bool?;
        return true;
      },
      builder: (BuildContext context) {
        var d = Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: !isSingleNodeManager
                ? AppColors.containerBgColor
                : AppColors.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 16, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.containerBgColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        TextWidget('Node Dashboard',
                            style: CustomTextStyles.text20_700),
                        const SizedBox(width: 10),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: isSingleNodeManager,
                                onChanged: (value) {
                                  setState(() {
                                    isSingleNodeManager = value!;
                                  });
                                }),
                            const Text("Single node manager"),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Network by ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: '@prod_super',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextWidget(
                              '2023-12-22 14:10:46',
                              style: CustomTextStyles.text14_700,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        const SizedBox(width: 19),
                        AppButtonPrimary(
                            text: 'Refresh', onPressed: () {}, height: 32),
                      ],
                    ),
                  ),
                  if (!isLoading &&
                      isSingleNodeManager &&
                      netmonStatusList.isNotEmpty)
                    SizedBox(
                        height: 80,
                        child: NetmonTableNew(
                          netmonBoxes: [netmonStatusList[0]],
                        )),
                ],
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : isSingleNodeManager
                        ? SingleNodeNetworkPage(
                            netmonBox: netmonStatusList[0],
                          )
                        : NetmonTableNew(
                            netmonBoxes: netmonStatusList,
                            onBoxSelected: widget.onBoxSelected,
                          ),
              ),

              /// Todo: Table here
              // Container(
              //   color: Colors.green,
              //   width: double.maxFinite,
              //   height: 500,
              // )
            ],
          ),
        );
        return d;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Network status',
                  style: TextStyles.h2(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      currentSupervisor != null
                          ? 'Current supervisor: $currentSupervisor'
                          : 'No supervisor',
                      style: TextStyles.body(),
                    ),
                    const SizedBox(width: 8),
                    OverlayTarget(
                      targetKey: _settingsOverlayController.targetKey,
                      layerLink: _settingsOverlayController.layerLink,
                      groupID: _settingsOverlayController.tapRegionGroupID,
                      child: IconButtonWithTooltip(
                        onTap: currentSupervisor == null
                            ? null
                            : () async {
                                if (!_settingsOverlayController.canOpen) {
                                  _settingsOverlayController
                                      .closeWithResult(null);
                                  return;
                                }
                                const Alignment targetAnchor =
                                    Alignment.bottomRight;
                                const Alignment followerAnchor =
                                    Alignment.bottomLeft;

                                final dynamic returnedValue =
                                    await _settingsOverlayController
                                        .showOverlay(
                                  context: context,
                                  isModal: false,
                                  targetAnchor: targetAnchor,
                                  followerAnchor: followerAnchor,
                                  contentOffset: const Offset(15, 175),
                                  width: 250,
                                  maxHeight: 200,

                                  // maxWidth: widget.maxContentWidth,
                                  // maxHeight: widget.maxContentHeight,
                                  shellBuilder: (context, content) => content,
                                  contentBuilder: (context, controller) {
                                    return PreferredSupervisorMenu(
                                      overlayController:
                                          _settingsOverlayController,
                                      supervisors: supervisorIds,
                                      selectedSupervisor: currentSupervisor!,
                                    );
                                  },
                                  // onTapOutside: widget.onTapOutside,
                                );
                                if (returnedValue != null) {
                                  currentSupervisor = returnedValue as String;
                                }
                              },
                        icon: CarbonIcons.settings,
                        tooltipMessage: 'Set preferred supervisor',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: NetmonTable(
                  boxStatusList: netmonStatusList,
                  // onBoxSelected: widget.onBoxSelected,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Map<String, dynamic> decodeData(String encodedData) {
    return XpandUtils.decodeEncryptedGzipMessage(encodedData);
  }
}
