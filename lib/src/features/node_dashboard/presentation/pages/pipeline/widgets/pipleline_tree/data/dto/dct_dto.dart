part of ai;

class AIDCTSnapshot {
  const AIDCTSnapshot({
    required this.image,
    required this.width,
    required this.height,
  });

  factory AIDCTSnapshot.fromMap(Map<String, dynamic> json) {
    return AIDCTSnapshot(
      image: base64Decode(json['image'] as String),
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  final Uint8List? image;
  final int width;
  final int height;
}

class AIDCTListItem {
  AIDCTListItem({
    required this.type,
    required this.name,
    required this.description,
  });

  factory AIDCTListItem.fromMap(Map<String, dynamic> json) => AIDCTListItem(
        type: json['type'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );
  String type;
  String name;
  String description;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'name': name,
        'description': description,
      };
}

class AIDCT {
  AIDCT({
    required this.name,
    required this.description,
    required this.type,
    required this.fields,
  });

  factory AIDCT.fromMap(Map<String, dynamic> json) => AIDCT(
        name: json['name'] as String,
        description: json['description'] as String,
        type: json['type'] as String,
        fields: (json['fields'] as List<dynamic>)
            .map(
              (dynamic x) => AIDCTField.fromMap(x as JsonMap),
            )
            .toList(),
      );
  String name;
  String description;
  String type;
  List<AIDCTField> fields;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'description': description,
        'type': type,
        'fields': List<dynamic>.from(
          fields.map(
            (AIDCTField x) => x.toMap(),
          ),
        ),
      };
}

class AIDCTField {
  AIDCTField({
    required this.key,
    required this.type,
    required this.label,
    required this.description,
    required this.defaultValue,
    required this.required,
  });

  factory AIDCTField.fromMap(Map<String, dynamic> json) => AIDCTField(
        key: json['key'] as String,
        type: json['type'] as String,
        label: json['label'] as String,
        description: json['description'] as String,
        defaultValue: json['default'],
        required: json['required'] as bool,
      );
  String key;
  String type;
  String label;
  String description;
  dynamic defaultValue;
  bool required;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'key': key,
        'type': type,
        'label': label,
        'description': description,
        'default': defaultValue,
        'required': required,
      };
}

typedef AIDCTValues = Map<String, dynamic>;
