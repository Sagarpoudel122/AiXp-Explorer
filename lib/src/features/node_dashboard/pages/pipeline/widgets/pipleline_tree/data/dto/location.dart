

import 'package:e2_explorer/http_client/index.dart';
import 'package:e2_explorer/src/features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/business_client.dart';
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.uuid,
    required this.name,
    this.timezone,
    this.partitions = const <dynamic>[],
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.client,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    final BusinessClient? client = map['client'] != null
        ? BusinessClient.fromMap(map['client'] as JsonMap)
        : null;
    return Location(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      timezone: map['timezone'] as String?,
      createdDate: map['createdDate'] == null
          ? null
          : DateTime.parse(map['createdDate'] as String),
      updatedDate: map['updatedDate'] == null
          ? null
          : DateTime.parse(map['updatedDate'] as String),
      deletedDate: map['deletedDate'] == null
          ? null
          : DateTime.parse(map['deletedDate'] as String),
      // partitions: map['partitions'] as List<dynamic>?,
      // client: client,
    );
  }

  final String uuid;
  final String name;
  final String? timezone;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final List<dynamic>? partitions;
  final BusinessClient? client;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'partitions': partitions,
    };
  }

  Location copyWith({
    String? uuid,
    String? name,
    String? timezone,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
    List<dynamic>? partitions,
  }) {
    return Location(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedDate: deletedDate ?? this.deletedDate,
      partitions: partitions ?? this.partitions,
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => <Object?>[
        uuid,
        name,
        timezone,
        createdDate,
        updatedDate,
        deletedDate,
        partitions,
      ];
}

class LocationFull extends Location {
  const LocationFull({
    required super.uuid,
    required super.name,
    super.timezone,
    super.partitions = const <dynamic>[],
    super.createdDate,
    super.updatedDate,
    super.deletedDate,
    required this.client,
  });
  factory LocationFull.fromMap(Map<String, dynamic> map) {
    final Location base = Location.fromMap(map);
    final BusinessClient client =
        BusinessClient.fromMap(map['client'] as JsonMap);
    return LocationFull(
      uuid: base.uuid,
      name: base.name,
      timezone: base.timezone,
      partitions: base.partitions,
      createdDate: base.createdDate,
      updatedDate: base.updatedDate,
      deletedDate: base.deletedDate,
      client: client,
    );
  }

  final BusinessClient client;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'client': client.toMap(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
        uuid,
        name,
        timezone,
        createdDate,
        updatedDate,
        deletedDate,
        partitions,
        client,
      ];
}
