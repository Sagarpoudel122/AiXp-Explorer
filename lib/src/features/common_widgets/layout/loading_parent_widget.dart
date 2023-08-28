import 'package:flutter/material.dart';

class LoadingParentWidget extends StatelessWidget {
  const LoadingParentWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return child;
    }
  }
}
