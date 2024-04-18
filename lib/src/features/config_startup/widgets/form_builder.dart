import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

enum FormBuilderType {
  text,
  boolean,
  map,
  list;

  FormBuilderType get type => this;
  static FormBuilderType fromInstanceType(dynamic instanceType) {
    if (instanceType is String ||
        instanceType is int ||
        instanceType is double ||
        instanceType is num ||
        instanceType is DateTime ||
        instanceType is Duration ||
        instanceType == null) {
      return FormBuilderType.text;
    } else if (instanceType is bool) {
      return FormBuilderType.boolean;
    } else if (instanceType is List) {
      return FormBuilderType.list;
    } else if (instanceType is Map<String, dynamic>) {
      return FormBuilderType.map;
    } else {
      throw Exception('Unsupported type');
    }
  }
}

class FormBuilder extends StatefulWidget {
  const FormBuilder({
    Key? key,
    required this.type,
    required this.label,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final FormBuilderType type;
  final String label;
  final dynamic initialValue;
  final void Function(String value, FormBuilderType formType)? onChanged;

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString());
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text, widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(widget.label),
        const SizedBox(height: 10),
        if (widget.type == FormBuilderType.text)
          TextField(controller: _controller),
        if (widget.type == FormBuilderType.boolean)
          CustomDropDown<bool>(
            onChanged: (value) {},
            value: true,
            controller: _controller,
            hintText: "Select Option",
            dropDownItems: const [
              DropdownMenuItem(
                value: true,
                child: Text("True"),
              ),
              DropdownMenuItem(
                value: false,
                child: Text("False"),
              ),
            ],
          ),
      ],
    );
  }
}

class JsonFormBuilder extends StatefulWidget {
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic> newData)? onChanged;

  const JsonFormBuilder({super.key, required this.data, this.onChanged});

  @override
  State<JsonFormBuilder> createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {
  late Map<String, dynamic> newData;

  @override
  void initState() {
    super.initState();
    newData = Map.from(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildFields(widget.data, ''),
    );
  }

  List<Widget> _buildFields(Map<String, dynamic> jsonData, String parentKey) {
    List<Widget> fields = [];

    jsonData.forEach((key, value) {
      String fieldKey = parentKey.isNotEmpty ? '$parentKey.$key' : key;
      if (value is Map) {
        fields.addAll(_buildFields(value as Map<String, dynamic>, fieldKey));
      } else if (value is List) {
        for (int i = 0; i < value.length; i++) {
          if (value[i] is Map) {
            fields.addAll(_buildFields(value[i], '$fieldKey[$i]'));
          } else {
            fields.add(
              FormBuilder(
                type: FormBuilderType.fromInstanceType(value[i]),
                label: '$fieldKey[$i]',
                initialValue: value[i],
                onChanged: (newValue, type) {
                  _updateData(fieldKey, i, newValue);
                },
              ),
            );
          }
        }
      } else {
        fields.add(
          FormBuilder(
            type: FormBuilderType.fromInstanceType(value),
            label: fieldKey,
            initialValue: value,
            onChanged: (newValue, type) {
              _updateData(fieldKey, null, newValue);
            },
          ),
        );
      }
    });

    return fields;
  }

  void _updateData(String key, int? index, String value) {
    List<String> keys = key.split('.');
    dynamic currentData = newData;

    for (int i = 0; i < keys.length - 1; i++) {
      currentData = currentData[keys[i]];
    }

    if (index != null) {
      currentData[keys.last][index] = value;
    } else {
      currentData[keys.last] = value;
    }

    widget.onChanged?.call(newData);
  }
}
