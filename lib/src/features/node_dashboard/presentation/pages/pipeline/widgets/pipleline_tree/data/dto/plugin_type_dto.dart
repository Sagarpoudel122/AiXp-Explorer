part of ai;

class AIPluginType {
  AIPluginType({
    required this.signature,
    required this.name,
    required this.description,
  });

  factory AIPluginType.fromMap(Map<String, dynamic> json) => AIPluginType(
        signature: json['signature'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );
  String signature;
  String name;
  String description;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'signature': signature,
        'name': name,
        'description': description,
      };
}
