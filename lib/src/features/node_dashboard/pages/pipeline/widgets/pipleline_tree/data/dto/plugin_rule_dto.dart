part of ai;

class AIPluginRuleDTO {
  AIPluginRuleDTO({
    required this.actions,
    required this.useDefaultOutsideHours,
    required this.schedule,
    required this.licensePlateList,
  });

  factory AIPluginRuleDTO.fromMap(Map<String, dynamic> map) {
    return AIPluginRuleDTO(
      actions: (map['actions'] as List<dynamic>).map((dynamic e) => ActionReference.fromMap(e as JsonMap)).toList(),
      useDefaultOutsideHours: map['useDefaultOutsideHours'] as bool,
      schedule: map['schedule'] as String?,
      licensePlateList: map['licensePlateList'] as String,
    );
  }

  factory AIPluginRuleDTO.fromJson(String source) =>
      AIPluginRuleDTO.fromMap(json.decode(source) as Map<String, dynamic>);
  final List<ActionReference> actions;
  final bool useDefaultOutsideHours;
  final String? schedule;
  final String licensePlateList;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actions': actions.map((ActionReference x) => x.toMap()).toList(),
      'useDefaultOutsideHours': useDefaultOutsideHours,
      'schedule': schedule,
      'licensePlateList': licensePlateList,
    };
  }

  String toJson() => json.encode(toMap());
}
