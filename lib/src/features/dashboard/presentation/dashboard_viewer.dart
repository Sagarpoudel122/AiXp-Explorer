import 'package:flutter/material.dart';

class DashBoardViewer extends StatelessWidget {
  const DashBoardViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
