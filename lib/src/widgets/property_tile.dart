import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyTitle extends StatefulWidget {
  const PropertyTitle({
    super.key,
    required this.parameterKey,
    required this.name,
    required this.description,
    this.isPropertyFocus = false,
    this.isDifferentFromDefault = false,
    this.isError = false,
    required this.child,
  });

  final String name;
  final String parameterKey;
  final String description;
  final bool isDifferentFromDefault;
  final bool isError;
  final bool isPropertyFocus;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _PropertyTitleState();
}

class _PropertyTitleState extends State<PropertyTitle>
    with SingleTickerProviderStateMixin {
  final Color foregroundColor = const Color(0xffBDBDBD);
  final Color foregroundColorHover = Colors.white;
  Color selectedColor = const Color(0xffBDBDBD);
  bool isFocus = false;
  bool isExpanded = true;

  late AnimationController controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = ColorTween(
      begin: foregroundColor,
      end: foregroundColorHover,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => isExpanded = !isExpanded);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: isExpanded
                            ? Icon(
                                CarbonIcons.chevron_down,
                                color: foregroundColor,
                                size: 16,
                              )
                            : Icon(
                                CarbonIcons.chevron_right,
                                color: foregroundColor,
                                size: 16,
                              ),
                      ),
                      const SizedBox(width: 4),
                      MouseRegion(
                        onHover: (PointerHoverEvent event) {
                          controller.forward();
                        },
                        onExit: (PointerExitEvent event) {
                          controller.reverse();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                widget.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: animation.value,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              // Add a margin to let some space between the window borders and the tooltip borders
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              textStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffBDBDBD),
                                fontSize: 14,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff1F1F1F),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  color: const Color(0xffBDBDBD),
                                ),
                              ),
                              message: _wrapDescription(widget.description, 45),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 150),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: widget.isPropertyFocus
                                    ? Icon(
                                        CarbonIcons.help,
                                        color: animation.value,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Spacer(),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: null,
            ),
            const SizedBox(width: 4),
            PropertyChangedIndicator(
              isError: widget.isError,
              isFocus: isFocus,
              isDifferentFromDefault: widget.isDifferentFromDefault,
            )
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.decelerate,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget child, Animation<double> animation) =>
              SizeTransition(
            sizeFactor: animation,
            axisAlignment: 1,
            child: child,
          ),
          child: isExpanded
              ? Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    widget.child,
                  ],
                )
              : null,
        ),
      ],
    );
  }

  String _wrapDescription(String text, int lineLength) {
    final List<String> splitText = text.split(' ');

    String lineText = '';
    String finalText = '';

    for (final String element in splitText) {
      if (lineText.length + element.length < lineLength) {
        lineText += ' $element';
      } else {
        finalText += '$lineText\n';
        lineText = element;
      }
    }

    finalText += lineText;
    finalText = finalText.trim();
    return finalText;
  }
}

class PropertyChangedIndicator extends StatefulWidget {
  const PropertyChangedIndicator({
    super.key,
    required this.isFocus,
    this.onTap,
    this.isDifferentFromDefault = false,
    this.isError = false,
  });

  final bool isFocus;
  final void Function()? onTap;
  final bool isDifferentFromDefault;
  final bool isError;

  @override
  State<StatefulWidget> createState() => _PropertyChangedIndicatorState();
}

class _PropertyChangedIndicatorState extends State<PropertyChangedIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: widget.isError
          ? const SizedBox(
              height: 28,
              width: 28,
              child: Center(
                child: Icon(
                  Icons.circle,
                  size: 8,
                  color: ColorStyles.red,
                ),
              ),
            )
          : widget.isDifferentFromDefault
              ? const SizedBox(
                  height: 28,
                  width: 28,
                  child: Center(
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: Color(0xff3399FF),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Icon(
                      Icons.circle_outlined,
                      color: Color(0xffBDBDBD),
                      size: 8,
                    ),
                  ),
                ),
    );
  }
}
