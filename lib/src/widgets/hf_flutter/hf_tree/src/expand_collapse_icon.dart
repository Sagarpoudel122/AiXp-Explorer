
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class ExpandCollapseIcon extends StatefulWidget {
  const ExpandCollapseIcon({
    super.key,
    required this.expanded,
    required this.hasChildren,
    required this.onTap,
    required this.isLoading,
  });
  final bool expanded;
  final bool hasChildren;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  State<ExpandCollapseIcon> createState() => _ExpandCollapseIconState();
}

class _ExpandCollapseIconState extends State<ExpandCollapseIcon> {
  double iconContainerWidth = 22;
  double iconContainerHeight = 22;
  double iconSize = 18;
  @override
  Widget build(BuildContext context) {
    if (!widget.hasChildren) {
      return SizedBox(
        width: iconContainerWidth,
        height: iconContainerHeight,
        child: Center(
          child: widget.isLoading
              ? const SizedBox.square(
                  dimension: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const SizedBox.shrink(),
        ),
      );
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap, // onHover won't work without it
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        hoverColor: const Color.fromARGB(255, 66, 66, 67),

        child: SizedBox(
          width: iconContainerWidth,
          height: iconContainerHeight,
          child: Center(
            child: !widget.isLoading
                ? widget.hasChildren
                    ? Icon(
                        widget.expanded ? CarbonIcons.chevron_down : CarbonIcons.chevron_right,
                        size: iconSize,
                        color: Colors.grey[200],
                      )
                    : Container()
                : const SizedBox.square(
                    dimension: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
          ),
        ),
      ),
    );
  }
}