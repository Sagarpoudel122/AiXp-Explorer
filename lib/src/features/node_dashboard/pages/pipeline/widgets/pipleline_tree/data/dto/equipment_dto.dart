

import 'dart:convert';

import 'package:e2_explorer/src/features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/business_client.dart';
import 'package:e2_explorer/src/features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/location.dart';
import 'package:e2_explorer/src/features/node_dashboard/pages/pipeline/widgets/pipleline_tree/index.dart';

List<EquipmentDTO> equipmentsFromJson(String str) => List<EquipmentDTO>.from(
      (json.decode(str) as List<dynamic>).map(
        (dynamic x) => EquipmentDTO.fromMap(x as Map<String, dynamic>),
      ),
    );

String equipmentsToJson(List<EquipmentDTO> data) =>
    json.encode(List<dynamic>.from(data.map((EquipmentDTO x) => x.toMap())));

class EquipmentActionDTO extends ActionReferenceBase {
  EquipmentActionDTO({
    required this.uuid,
    required this.name,
  });

  factory EquipmentActionDTO.fromMap(Map<String, dynamic> map) {
    return EquipmentActionDTO(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
    );
  }

  factory EquipmentActionDTO.fromJson(String source) =>
      EquipmentActionDTO.fromMap(json.decode(source) as Map<String, dynamic>);
  final String uuid;
  final String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'EquipmentActionDTO - uuid: $uuid - name: $name';
  }

  @override
  ActionReference get reference => ActionReference(actionId: uuid, name: name);
}

class EquipmentDTO {
  EquipmentDTO({
    required this.uuid,
    required this.name,
    required this.description,
    required this.type,
    required this.metadata,
    required this.location,
    required this.updatedDate,
    required this.client,
  });

  factory EquipmentDTO.fromMap(Map<String, dynamic> json) => EquipmentDTO(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: (json['description'] as String?) ?? '',
        type: json['type'] as String,
        metadata: json['metadata'] as Map<String, dynamic>,
        location: Location.fromMap(json['location'] as Map<String, dynamic>),
        updatedDate: DateTime.parse(json['updatedDate'] as String),
        client: BusinessClient.fromMap(json['client'] as Map<String,dynamic>),
      );
  String uuid;
  String name;
  String description;
  String type;
  Map<String, dynamic> metadata;
  Location location;
  DateTime updatedDate;
  BusinessClient client;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'name': name,
        'description': description,
        'type': type,
        'metadata': metadata,
        'location': location.uuid,
        'updatedDate': updatedDate.toIso8601String(),
      };
}
