

class DynamicFormTemplate {
  DynamicFormTemplate({
    required this.name,
    required this.templateFor,
    required this.fields,
    required this.category,
  });

  factory DynamicFormTemplate.fromMap(Map<String, dynamic> json) =>
      DynamicFormTemplate(
        name: json['name'] as String,
        templateFor: json['for'] as String,
        category: json['category'] == null ? 'N/A' : json['category'] as String,
        fields: List<DynamicField>.from(
          (json['fields'] as List<dynamic>).map(
              (dynamic x) => DynamicField.fromJson(x as Map<String, dynamic>)),
        ),
      );
  String name;
  String templateFor;
  String category;
  List<DynamicField> fields;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'for': templateFor,
        'category': category,
        'fields':
            List<dynamic>.from(fields.map((DynamicField x) => x.toJson())),
      };
}

class DynamicField {
  DynamicField({
    required this.name,
    required this.dataType,
    required this.fieldType,
    required this.required,
    required this.label,
    this.value,
    this.options,
    this.fields,
    this.dependsOn,
    this.readOnly = false,
  });

  factory DynamicField.fromJson(Map<String, dynamic> json) {
    List<DynamicField> fields = <DynamicField>[];

    if (json['fields'] != null &&
        (json['fields'] as List<dynamic>).isNotEmpty) {
      fields = ((json['fields'] as List<dynamic>).first as List<dynamic>)
          .map((dynamic x) => DynamicField.fromJson(x as Map<String, dynamic>))
          .toList();
    }

    return DynamicField(
      name: json['name'] as String,
      dataType: DynamicFieldDataType.values.firstWhere(
          (DynamicFieldDataType element) => element.name == json['dataType']),
      fieldType: json['fieldType'] as String,
      required: json['required'] as bool,
      label: json['label'] as String,
      value: json['value'],
      options: json['options'] == null
          ? <DynamicFieldOption>[]
          : List<DynamicFieldOption>.from(
              (json['options'] as List<dynamic>).map(
                (dynamic x) =>
                    DynamicFieldOption.fromJson(x as Map<String, dynamic>),
              ),
            ),
      fields: fields,
      dependsOn: json['dependsOn'] as String?,
      readOnly: json['readonly'] as bool? ?? false,
    );
  }

  DynamicField copyWith({
    dynamic value,
  }) {
    return DynamicField(
      name: name,
      dataType: dataType,
      fieldType: fieldType,
      required: required,
      label: label,
      value: value ?? this.value,
      options: options,
      fields: fields,
      dependsOn: dependsOn,
      readOnly: readOnly,
    );
  }

  String name;
  DynamicFieldDataType dataType;
  String fieldType;
  bool required;
  String label;
  dynamic value;
  List<DynamicFieldOption>? options;
  List<DynamicField>? fields;
  String? dependsOn;
  bool readOnly;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'dataType': dataType.name,
        'fieldType': fieldType,
        'required': required,
        'label': label,
        'value': value,
        'options': options == null
            ? <DynamicFieldOption>[]
            : List<dynamic>.from(
                options!.map((DynamicFieldOption x) => x.toJson())),
        'fields': fields == null
            ? <DynamicField>[]
            : List<dynamic>.from(fields!.map((DynamicField x) => x.toJson())),
        'readonly': readOnly,
      };

  Set<String> getKeyDependencies() {
    final Set<String> result = <String>{};
    if (fields != null) {
      for (final DynamicField subfield in fields!) {
        if (subfield.dependsOn != null) {
          result.add(subfield.dependsOn!);
        }
        result.addAll(subfield.getKeyDependencies());
      }
    }
    return result;
  }
}

enum DynamicFieldDataType { metadata, property }

class DynamicFieldOption {
  DynamicFieldOption({
    required this.text,
    required this.value,
  });

  factory DynamicFieldOption.fromJson(Map<String, dynamic> json) =>
      DynamicFieldOption(
        text: json['text'] as String,
        value: json['value'] as String,
      );
  String text;
  String value;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'value': value,
      };
}
