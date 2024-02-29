// ignore_for_file: public_member_api_docs, sort_constructors_first
part of ai;

class AIPluginInstanceData {
  const AIPluginInstanceData({
    required this.edgeUuid,
    required this.clientUuid,
    required this.pluginInstance,
    // required this.onUpdateSuccessful,
  });

  final String edgeUuid;
  final String? clientUuid;
  final AIPluginInstance pluginInstance;
  // final void Function()? onUpdateSuccessful;
}

class AIPluginInstance {
  AIPluginInstance({
    required this.name,
    required this.boxName,
    required this.pipelineName,
    required this.signature,
    required this.config,
    this.tags,
    this.template,
    this.schedule,
    this.partition,
    required this.schema,
    required this.isDraft,
    this.defaultActions = const <ActionReference>[],
    this.lists = const <AIPluginRuleDTO>[],
  });

  factory AIPluginInstance.fromDTOAndSchema({
    required String boxName,
    required String pipelineName,
    required AIPluginInstanceDTO dto,
    required AIPluginSchemaDTO schema,
  }) {
    return AIPluginInstance(
      boxName: boxName,
      pipelineName: pipelineName,
      signature: dto.signature,
      config: dto.config,
      tags: dto.tags,
      template: dto.template,
      schedule: dto.schedule,
      partition: dto.partition,
      name: dto.name,
      schema: schema,
      defaultActions: dto.defaultActions,
      lists: dto.lists,
      isDraft: false,
    );
  }

  String get key => '$boxName|$pipelineName|$name';

  final String boxName;
  final String pipelineName;
  final String name;
  final String signature;
  final JsonMap config;
  final JsonMap? tags;
  final String? template;
  final String? schedule;
  final String? partition;
  final List<ActionReference> defaultActions;
  final List<AIPluginRuleDTO> lists;
  final AIPluginSchemaDTO schema;
  final bool isDraft;

  AIPluginInstance copyWith({
    String? boxName,
    String? pipelineName,
    String? name,
    String? signature,
    JsonMap? config,
    JsonMap? tags,
    String? template,
    String? schedule,
    String? partition,
    bool? isDraft,
    AIPluginSchemaDTO? schema,
  }) {
    return AIPluginInstance(
      boxName: boxName ?? this.boxName,
      pipelineName: pipelineName ?? this.pipelineName,
      name: name ?? this.name,
      signature: signature ?? this.signature,
      config: config ?? this.config,
      tags: tags ?? this.tags,
      template: template ?? this.template,
      schedule: schedule ?? this.schedule,
      partition: partition ?? this.partition,
      isDraft: isDraft ?? this.isDraft,
      schema: schema ?? this.schema,
    );
  }
}
