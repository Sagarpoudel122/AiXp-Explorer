


import 'dart:convert';

import 'package:e2_explorer/http_client/index.dart';
import 'package:e2_explorer/src/utils/nullable_field.dart';
import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/widgets/pipleline_tree/data/dto/language.dart';
import 'package:equatable/equatable.dart';

class BusinessClient extends Equatable {
  const BusinessClient({
    required this.uuid,
    required this.name,
    // this.dispatchIntegration = false,
    this.active = false,
    this.languages = const <Language>[],
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BusinessClient.fromMap(Map<String, dynamic> map) {
    return BusinessClient(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      // dispatchIntegration: map['dispatchIntegration'] as bool,
      active: map['active'] as bool? ?? false,
      languages: map['languages'] is JsonList
          ? (map['languages'] as JsonList)
              .cast<JsonMap>()
              .map(Language.fromMap)
              .toList()
          : const <Language>[],
      createdAt: map['createdAt'] is String
          ? DateTime.tryParse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] is String
          ? DateTime.tryParse(map['updatedAt'] as String)
          : null,
      deletedAt: map['deletedAt'] is String
          ? DateTime.tryParse(map['deletedAt'] as String)
          : null,
    );
  }

  factory BusinessClient.fromJson(String source) =>
      BusinessClient.fromMap(json.decode(source) as Map<String, dynamic>);
  final String uuid;
  final String name;
  final bool active;
  // final bool dispatchIntegration;
  final List<Language> languages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  @override
  List<Object?> get props {
    return <Object?>[
      uuid,
      name,
      // dispatchIntegration,
      active,
      languages,
      createdAt,
      updatedAt,
      deletedAt,
    ];
  }

  BusinessClient copyWith({
    String? uuid,
    String? name,
    bool? dispatchIntegration,
    bool? active,
    List<Language>? languages,
    Nullable<DateTime>? createdAt,
    Nullable<DateTime>? updatedAt,
    Nullable<DateTime>? deletedAt,
  }) {
    return BusinessClient(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      // dispatchIntegration: dispatchIntegration ?? this.dispatchIntegration,
      active: active ?? this.active,
      languages: languages ?? this.languages,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
      deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      // 'dispatchIntegration': dispatchIntegration,
      'active': active,
      'languages': languages.map((Language language) {
        return language.toMap();
      }).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
