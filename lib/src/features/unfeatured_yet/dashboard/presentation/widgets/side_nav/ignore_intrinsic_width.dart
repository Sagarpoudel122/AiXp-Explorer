
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IgnoreIntrinsicWidth extends SingleChildRenderObjectWidget {
  const IgnoreIntrinsicWidth({
    super.key,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => MinIntrinsicWidthRenderBox();
}

class MinIntrinsicWidthRenderBox extends RenderProxyBox {
  @override
  double computeMinIntrinsicWidth(double height) => 0;

  @override
  double computeMaxIntrinsicWidth(double height) => 0;
}
