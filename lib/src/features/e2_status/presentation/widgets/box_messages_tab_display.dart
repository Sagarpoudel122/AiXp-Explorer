import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BoxViewerTab {
  resources,
  pipelines,
  comms;

  static BoxViewerTab fromIndex(int index) {
    return BoxViewerTab.values[index];
  }
}

class BoxMessagesTabDisplay extends StatefulWidget {
  const BoxMessagesTabDisplay({
    super.key,
    required this.resourcesView,
    required this.pipelinesView,
    required this.commsView,
    this.onTabChanged,
  });

  final Widget resourcesView;
  final Widget pipelinesView;
  final Widget commsView;

  // final Widget fullPayloadsView;
  final void Function(BoxViewerTab tab)? onTabChanged;

  @override
  State<StatefulWidget> createState() => _BoxMessagesTabDisplayState();
}

class _BoxMessagesTabDisplayState extends State<BoxMessagesTabDisplay>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int _tabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabIndex = _tabController.index;
    _tabController.addListener(() {
      if (_tabIndex != _tabController.index) {
        final tab = BoxViewerTab.fromIndex(_tabController.index);
        widget.onTabChanged?.call(tab);
        setState(() {
          _tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 3 / 3,
                    child: TabBar(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.only(right: 24),
                      isScrollable: true,
                      dividerHeight: 0,
                      indicatorWeight: 4,
                      controller: _tabController,
                      indicator: ShapeDecoration(
                        shape: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 4.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        gradient: AppColors.tabBarIndicatorGradient,
                      ),
                      indicatorPadding: const EdgeInsets.only(top: 20),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondaryColor,
                      ),
                      tabs: const [
                        Text('Resources'),
                        Text('Pipelines'),
                        Text('Comms'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppButtonSecondary(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              text: 'Filter',
              icon: SvgPicture.asset(
                AssetUtils.getSvgIconPath('sliders'),
                color: AppColors.buttonSecondaryIconColor,
              ),
              borderColor: Colors.transparent,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomPopup();
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              /// Resources tab
              widget.resourcesView,

              /// Pipelines tab
              widget.pipelinesView,

              /// Comms tab
              widget.commsView,
            ],
          ),
        )
      ],
    );
  }
}

class CustomPopup extends StatefulWidget {
  const CustomPopup({super.key});

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  bool isNotiication = false;
  bool isPayload = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the popup when tapped outside
        Navigator.of(context).pop();
      },
      child: Stack(
        children: [
          Container(
            color: Colors.black
                .withOpacity(0.5), // Semi-transparent black background
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom:
                MediaQuery.of(context).size.height * 0.55, // Adjust as needed
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: 180,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.alertDialogBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  child: Container(
                    color: AppColors.alertDialogBgColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: isNotiication,
                                onChanged: (value) {
                                  setState(() {
                                    isNotiication = value ?? false;
                                  });
                                }),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Notifications",
                              style: TextStyles.custom(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isPayload,
                                onChanged: (value) {
                                  setState(() {
                                    isPayload = value!;
                                  });
                                }),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Payload",
                              style: TextStyles.custom(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
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
