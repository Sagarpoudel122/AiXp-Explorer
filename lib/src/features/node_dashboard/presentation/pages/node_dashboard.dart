import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/pipeline_screen.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../coms/coms.dart';

class NodeDashBoard extends StatefulWidget {
  const NodeDashBoard({super.key});

  @override
  State<NodeDashBoard> createState() => _NodeDashBoardState();
}

class _NodeDashBoardState extends State<NodeDashBoard> {
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool isSelected(int index) => selectedIndex == index;

  Color color(int index) =>
      isSelected(index) ? Colors.white : Colors.white.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    List<String> pageName = [
      "Resources",
      "Piplines",
      "Comms",
    ];
    List<Widget> pages = const [
      Center(
        child: Text("Resources"),
      ),
      PipeLine(
        boxName: '',
      ),
      Comms(boxName: ''),
    ];
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Node Dashboars'),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                    pageName.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: InkWell(
                            onTap: () => changeIndex(index),
                            child: Column(
                              children: [
                                IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Text(
                                        pageName[index],
                                        style: TextStyles.cardTitle(
                                            color: color(index)),
                                      ),
                                      const SizedBox(width: 6),
                                      Visibility(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            gradient: isSelected(index)
                                                ? const LinearGradient(
                                                    colors: [
                                                      Color(0xFFC92063),
                                                      Color(0xFFA63CC8),
                                                      Color(0xFF4E4BDE),
                                                    ],
                                                  )
                                                : null,
                                          ),
                                          height: 4,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Filters')),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: pages[selectedIndex])
        ],
      ),
    ));
  }
}
