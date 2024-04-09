import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/widgets/pipleline_tree/index.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class PipeLine extends StatelessWidget {
  const PipeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.containerBgColor,
                ),
                child: const AITree(
                  isSuper: true,
                ),
              )),
          const SizedBox(width: 20),
          Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.containerBgColor,
                ),

                //TO:DO Stream Data
                child: const Center(
                  child: Text("Stream Data"),
                ),
              ))
        ],
      ),
    );
  }
}
