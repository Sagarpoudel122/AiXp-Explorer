// ignore_for_file: public_member_api_docs, sort_constructors_first
part of ai;

class AIPluginInstanceReference {
  AIPluginInstanceReference({
    required this.signature,
    required this.name,
    required this.tags,
  });

  factory AIPluginInstanceReference.fromMap(Map<String, dynamic> json) => AIPluginInstanceReference(
        signature: json['signature'] as String,
        name: json['name'] as String,
        tags: json['tags'] as JsonMap,
      );
  String signature;
  String name;
  JsonMap tags;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'signature': signature,
        'name': name,
        'tags': tags,
      };
}

class AIPluginInstanceDTO {
  AIPluginInstanceDTO({
    required this.signature,
    required this.name,
    required this.config,
    this.tags,
    this.template,
    this.schedule,
    this.partition,
    this.defaultActions = const <ActionReference>[],
    this.lists = const <AIPluginRuleDTO>[],
  });

  factory AIPluginInstanceDTO.fromMap(Map<String, dynamic> json) => AIPluginInstanceDTO(
        signature: json['signature'] as String,
        name: json['name'] as String,
        config: json['config'] as JsonMap,
        tags: json['tags'] as JsonMap?,
        template: json['template'] as String?,
        schedule: json['schedule'] as String?,
        partition: json['partition'] as String?,
        defaultActions: (json['defaultActions'] != null)
            ? (json['defaultActions'] as List<dynamic>)
                .map((dynamic e) => ActionReference.fromMap(e as JsonMap))
                .toList()
            : <ActionReference>[],
        lists: (json['lists'] != null)
            ? (json['lists'] as List<dynamic>).map((dynamic e) => AIPluginRuleDTO.fromMap(e as JsonMap)).toList()
            : <AIPluginRuleDTO>[],
      );

  String signature;
  String name;
  JsonMap config;

  JsonMap? tags;
  String? template;
  String? schedule;
  String? partition;
  List<ActionReference> defaultActions;
  List<AIPluginRuleDTO> lists;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signature': signature,
      'name': name,
      'config': config,
      'tags': tags,
      'template': template,
      'schedule': schedule,
      'partition': partition,
      'defaultActions': defaultActions.map((ActionReference e) => e.toMap()).toList(),
      'lists': lists.map((AIPluginRuleDTO e) => e.toMap()).toList(),
    };
  }

  AIPluginInstanceDTO copyWith({
    String? signature,
    String? name,
    JsonMap? config,
    JsonMap? tags,
    String? template,
    String? schedule,
    String? partition,
    List<ActionReference>? defaultActions,
    List<AIPluginRuleDTO>? lists,
  }) {
    return AIPluginInstanceDTO(
      signature: signature ?? this.signature,
      name: name ?? this.name,
      config: config ?? this.config,
      tags: tags ?? this.tags,
      template: template ?? this.template,
      schedule: schedule ?? this.schedule,
      partition: partition ?? this.partition,
      defaultActions: defaultActions ?? this.defaultActions,
      lists: lists ?? this.lists,
    );
  }
}

abstract class ActionReferenceBase {
  ActionReference get reference;
}

class ActionReference {
  ActionReference({
    required this.actionId,
    required this.name,
  });
  factory ActionReference.fromMap(Map<String, dynamic> map) {
    return ActionReference(
      actionId: map['actionId'] as String,
      name: map['name'] as String,
    );
  }
  final String actionId;
  final String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actionId': actionId,
      'name': name,
    };
  }
}
