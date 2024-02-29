part of ai;

class PluginActionDTO extends ActionReferenceBase {
  PluginActionDTO({
    required this.uuid,
    required this.name,
  });

  factory PluginActionDTO.fromMap(Map<String, dynamic> json) => PluginActionDTO(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
      );

  String uuid;
  String name;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'name': name,
      };

  @override
  String toString() {
    return 'PluginActionDTO - uuid: $uuid - name: $name';
  }

  @override
  ActionReference get reference => ActionReference(actionId: uuid, name: name);
}
