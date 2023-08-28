import 'package:flutter/material.dart';

class TabDisplay extends StatefulWidget {
  const TabDisplay({
    super.key,
    required this.children,
    required this.tabNames,
    this.resetIndexOnChange = false,
  });

  final List<Widget> children;
  final List<String> tabNames;
  final bool resetIndexOnChange;

  @override
  State<TabDisplay> createState() => _TabDisplayState();
}

class _TabDisplayState extends State<TabDisplay> with TickerProviderStateMixin {
  late TabController _tabController;
  late int _tabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.children.length, vsync: this);
    _tabIndex = _tabController.index;
    _tabController.addListener(() {
      if (_tabIndex != _tabController.index) {
        setState(() {
          _tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(TabDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print('changed depen  tab disp');
    // if (oldWidget.children != widget.children) {
    //   _tabController.dispose();
    //   _tabController = TabController(length: widget.children.length, vsync: this);
    //   _tabController.addListener(() {
    //     if (_tabIndex != _tabController.index) {
    //       setState(() {
    //         _tabIndex = _tabController.index;
    //       });
    //     }
    //   });
    //   if (widget.resetIndexOnChange) {
    //     _tabIndex = _tabController.index;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Container(
                    color: const Color(0xff282828),
                    width: double.infinity,
                    height: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 3 / 3,
                    child: TabBar(
                      indicatorColor: const Color(0xff0073E6),
                      controller: _tabController,
                      tabs: widget.tabNames
                          .map(
                            (name) => Tab(
                              text: name,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: const Color(0xff1F1F1F),
            child: IndexedStack(
              index: _tabIndex,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}
