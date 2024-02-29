
import 'dart:convert';

import 'package:e2_explorer/http_client/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Language extends Equatable {
  const Language({
    required this.name,
    required this.iso2,
  });

  factory Language.fromMap(JsonMap map) {
    return Language(
      name: map['name'] as String,
      iso2: map['iso2'] as String,
    );
  }

  factory Language.fromJson(String source) => Language.fromMap(json.decode(source) as JsonMap);
  final String name;
  final String iso2;

  Locale get locale => Locale(iso2);

  String get flagAssetUrl => 'assets/flags/$iso2.png';

  @override
  List<Object> get props {
    return <Object>[
      name,
      iso2,
    ];
  }

  Language copyWith({
    String? name,
    String? iso2,
  }) {
    return Language(
      name: name ?? this.name,
      iso2: iso2 ?? this.iso2,
    );
  }

  JsonMap toMap() {
    return <String, dynamic>{
      'name': name,
      'iso2': iso2,
    };
  }

  String toJson() => json.encode(toMap());
}
