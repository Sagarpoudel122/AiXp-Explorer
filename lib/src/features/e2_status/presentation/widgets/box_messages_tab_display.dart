import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
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
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
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
              onPressed: () {},
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
              widget.commsView
            ],
          ),
        )
      ],
    );
  }
}
