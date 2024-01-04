import 'package:e2_explorer/src/data/parameter_widget_data.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/widgets/property_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectionBar extends StatefulWidget {
  const SelectionBar({super.key, required this.parameterData});

  final ParameterWidgetData parameterData;

  @override
  State<StatefulWidget> createState() => _SelectionBarState();
}

class _SelectionBarState extends State<SelectionBar> {
  bool isFocus = false;
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.parameterData.initialValue as bool;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (PointerHoverEvent event) {
        setState(() => isFocus = true);
      },
      onExit: (PointerExitEvent event) {
        setState(() => isFocus = false);
      },
      child: PropertyTitle(
        name: widget.parameterData.label,
        description: widget.parameterData.description,
        isPropertyFocus: isFocus,
        parameterKey: widget.parameterData.parameterKey,
        child: SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<bool>(
            backgroundColor: ColorStyles.spaceGrey,
            thumbColor: const Color(0xff484B50),
            groupValue: value,
            onValueChanged: (bool? value) {
              setState(() {
                this.value = value ?? this.value;
              });
            },
            children: const <bool, Widget>{
              false: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'False',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
              true: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'True',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            },
          ),
        ),
        // child: HSInputField(
        //   inputFieldLabel: '',
        //   hintText: 'String value',
        //   textFieldController: textController,
        //   onChanged: (value) {
        //     BlocProvider.of<AiPluginBloc>(context).add(PropertyChanged(
        //       propertyKey: widget.parameterData.parameterKey,
        //       newValue: value,
        //     ));
        //   },
        // ),
      ),
    );
  }
}
