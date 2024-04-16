import 'package:e2_explorer/src/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

Type _unpackedType<T>() => T;

enum FormBuilderType {
  text,
  boolean,
  map,
  list;

  FormBuilderType get type => this;

//   from instanceType

  static FormBuilderType fromInstanceType(dynamic instanceType) {
    if (instanceType is String ||
        instanceType is int ||
        instanceType is double ||
        instanceType is num ||
        instanceType is DateTime ||
        instanceType is Duration) {
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
    super.key,
    required this.type,
    required this.label,
    this.hint,
    this.initialValue,
    this.isDisabled = false,
    this.onChanged,
    this.listType,
    this.mapType,
  });

  final FormBuilderType type;
  final String label;
  final String? hint;
  final String? initialValue;
  final bool isDisabled;
  final void Function(
          String value, FormBuilderType formType, int? index, String? key)?
      onChanged;
  final (String parentKey, List<dynamic> data)? listType;
  final (String parentKey, Map<String, dynamic> data)? mapType;

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    fillInitialValue();
  }

  void fillInitialValue() {
    _controller = TextEditingController(text: widget.initialValue)
      ..addListener(() {
        widget.onChanged?.call(_controller.text, widget.type, null, null);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.type == FormBuilderType.map &&
            (widget.mapType == null || (widget.mapType?.$2 ?? {}).isEmpty)) {
          return const SizedBox.shrink();
        } else if (widget.type == FormBuilderType.list &&
            (widget.listType == null || (widget.listType?.$2 ?? []).isEmpty)) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  if (widget.type != FormBuilderType.list &&
                      widget.type != FormBuilderType.map) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(widget.label),
                        const SizedBox(height: 10),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Builder(builder: (context) {
                return switch (widget.type) {
                  FormBuilderType.text => TextField(
                      onChanged: (value) {
                        widget.onChanged?.call(value, widget.type, null, null);
                      },
                      decoration: const InputDecoration(),
                      controller: _controller,
                    ),
                  FormBuilderType.boolean => CustomDropDown<bool>(
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
                  FormBuilderType.list => Builder(builder: (context) {
                      if (widget.listType == null ||
                          (widget.listType?.$2 ?? []).isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in (widget.listType?.$2 ?? [])) ...[
                            Builder(builder: (context) {
                              final index =
                                  (widget.listType?.$2 ?? []).indexOf(item);
                              return FormBuilder(
                                type: FormBuilderType.fromInstanceType(item),
                                label: '${widget.label}:[$index]',
                                initialValue: item.toString(),
                                onChanged: (value, __, _, key) {
                                  widget.onChanged?.call(
                                      value, widget.type, index, widget.label);
                                },
                              );
                            }),
                          ],
                        ],
                      );
                    }),
                  FormBuilderType.map => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item
                            in (widget.mapType?.$2 ?? {}).entries) ...[
                          FormBuilder(
                            type: FormBuilderType.fromInstanceType(item.value),
                            label: item.key,
                            initialValue: item.value.toString(),
                            onChanged: (value, type, _, __) {
                              widget.onChanged
                                  ?.call(value, type, null, item.key);
                            },
                          ),
                        ],
                      ],
                    ),
                };
              }),
            ],
          );
        }
      },
    );
  }
}
