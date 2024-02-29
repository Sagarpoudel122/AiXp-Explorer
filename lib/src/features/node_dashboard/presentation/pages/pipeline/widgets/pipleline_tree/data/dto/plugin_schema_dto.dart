part of ai;

class AIPluginSchemaDTO {
  AIPluginSchemaDTO({
    required this.armable,
    required this.name,
    required this.description,
    required this.type,
    required this.fields,
    required this.dct,
  });

  factory AIPluginSchemaDTO.fromMap(Map<String, dynamic> json) {
    return AIPluginSchemaDTO(
      armable: json['armable'] != null ? json['armable'] as bool : false,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((dynamic fieldJson) => AIPluginSchemaField.fromMap(fieldJson as JsonMap))
          .toList(),
      dct: AIPluginSchemaDCT.fromMap(json['dct'] as JsonMap),
    );
  }

  final bool armable;
  final String name;
  final String description;
  final String type;
  final List<AIPluginSchemaField> fields;
  final AIPluginSchemaDCT dct;
}

class AIPluginSchemaField {
  AIPluginSchemaField({
    required this.key,
    required this.type,
    required this.label,
    required this.description,
    required this.defaultValue,
    required this.required,
    required this.allowedValues,
  });

  factory AIPluginSchemaField.fromMap(Map<String, dynamic> json) {
    return AIPluginSchemaField(
      key: json['key'] as String,
      type: json['type'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      defaultValue: json['default'],
      required: json['required'] != null ? json['required'] as bool : false,
      allowedValues: json['allowedValues'] as List<dynamic>?,
    );
  }

  final String key;
  final String type;
  final String label;
  final String description;
  final dynamic defaultValue;
  final bool required;
  final List<dynamic>? allowedValues;
}

class AIPluginSchemaDCT {
  AIPluginSchemaDCT({
    required this.types,
    required this.fps,
    required this.areaType,
    required this.cropRequired,
  });

  factory AIPluginSchemaDCT.fromMap(Map<String, dynamic> json) {
    return AIPluginSchemaDCT(
      types: List<String>.from(json['types'] as List<dynamic>),
      fps: json['fps'] != null ? json['fps'] as int : 0,
      areaType: json['areaType'] != null ? json['areaType'] as String : 'full-screen',
      cropRequired: json['cropRequired'] as bool? ?? false,
    );
  }

  final List<String> types;
  final int fps;
  final String areaType;
  final bool cropRequired;
}
