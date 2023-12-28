import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChildSizeListener extends SingleChildRenderObjectWidget {
  const ChildSizeListener({
    super.key,
    super.child,
    this.onChanged,
    this.listenWidth = true,
    this.listenHeight = true,
  });

  final ValueChanged<Size>? onChanged;
  final bool listenWidth;
  final bool listenHeight;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SideNavChildSizeListenerRenderObject(
      onChanged: onChanged,
      listenWidth: listenWidth,
      listenHeight: listenHeight,
    );
  }
}

class _SideNavChildSizeListenerRenderObject extends RenderProxyBox {
  _SideNavChildSizeListenerRenderObject({
    required this.onChanged,
    required this.listenWidth,
    required this.listenHeight,
  });

  final ValueChanged<Size>? onChanged;
  final bool listenWidth;
  final bool listenHeight;
  Size? childSize;

  @override
  void performLayout() {
    super.performLayout();
    child?.layout(constraints, parentUsesSize: true);
    final Size? newSize = child?.size;
    final bool widthDiffers = listenWidth && newSize?.width != childSize?.width;
    final bool heightDiffers = listenHeight && newSize?.height != childSize?.height;

    if (newSize != null && (widthDiffers || heightDiffers)) {
      childSize = newSize;
      onChanged?.call(childSize!);
    }
  }
}
