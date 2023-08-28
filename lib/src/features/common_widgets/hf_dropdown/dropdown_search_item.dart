import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/features/common_widgets/hs_input_field.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropdownSearchItem extends StatefulWidget {
  const DropdownSearchItem({
    super.key,
    this.height = 40,
    this.selected = false,
    this.onChanged,
    this.onClear,
    this.onEscape,
  });

  final double height;
  final bool selected;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onEscape;

  @override
  State<StatefulWidget> createState() => _DropdownSearchItemState();
}

class _DropdownSearchItemState extends State<DropdownSearchItem> {
  late final TextEditingController _controller;
  late final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusScopeNode.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: FocusScope(
              node: _focusScopeNode,
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event is RawKeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      widget.onEscape?.call();
                    }
                  }
                },
                child: HSInputField(
                  onChanged: widget.onChanged,
                  inputFieldLabel: '',
                  hintText: '',
                  textFieldController: _controller,
                  autoValidateMode: AutovalidateMode.always,
                  textInputAction: TextInputAction.none,
                  enableBorder: false,
                  autofocus: true,
                  innerPadding: EdgeInsets.zero,
                  isDense: true,
                  prefixIcon: const Icon(
                    CarbonIcons.search,
                    color: ColorStyles.light900,
                    size: 20,
                  ),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : InkWell(
                          onTap: () {
                            _controller.clear();
                            widget.onChanged?.call(_controller.text);
                            widget.onClear?.call();
                          },
                          child: const Icon(
                            CarbonIcons.close,
                            color: ColorStyles.light900,
                            size: 20,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
