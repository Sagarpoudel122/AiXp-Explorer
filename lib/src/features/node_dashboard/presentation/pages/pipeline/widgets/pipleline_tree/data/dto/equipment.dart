// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:e2_explorer/src/features/node_dashboard/presentation/pages/pipeline/widgets/pipleline_tree/data/dto/dynamic_field.dart';

enum EquipmentColumn {
  tenant(),
  location,
  name(sortable: true),
  equipmentType(sortable: true),
  description(sortable: true),
  actions;

  const EquipmentColumn({this.sortable = false});

  final bool sortable;
}

class Equipment {
  final List<DynamicField> fieldsValues;
  final String uuid;
  final String name;
  final String type;

  Equipment({
    required this.fieldsValues,
    required this.uuid,
    required this.name,
    required this.type,
  });

  // DynamicField? getField({required String key}) {
  //   return fieldsValues
  //       .firstWhereOrNull((DynamicField element) => element.name == key);
  // }
}

extension EquipmentFieldValue on List<DynamicField> {
  T? getValue<T>(
    String fieldName,
  ) =>
      firstWhere((DynamicField element) => element.name == fieldName).value
          as T;
}
