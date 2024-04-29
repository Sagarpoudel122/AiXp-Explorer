part of ai;

class AIPipeline {
  AIPipeline({
    required this.boxName,
    required this.name,
    required this.type,
    required this.pluginCount,
  });

  factory AIPipeline.fromDTO({
    required String boxName,
    required AIPipelineDTO dto,
  }) {
    return AIPipeline(
      boxName: boxName,
      name: dto.name,
      type: dto.type,
      pluginCount: dto.pluginCount,
    );
  }

  final String boxName;
  final String name;
  final String type;
  final int pluginCount;

  String get key => '$boxName|$name';
}
