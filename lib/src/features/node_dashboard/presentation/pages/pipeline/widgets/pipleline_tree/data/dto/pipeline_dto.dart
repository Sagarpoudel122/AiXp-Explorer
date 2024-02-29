// ignore_for_file: public_member_api_docs, sort_constructors_first
part of ai;

class AIPipelineDTO {
  AIPipelineDTO({
    required this.name,
    required this.type,
    required this.status,
    required this.pluginCount,
  });

  factory AIPipelineDTO.fromMap(Map<String, dynamic> json) => AIPipelineDTO(
        name: json['name'] as String,
        type: json['type'] as String,
        status: json['status'] != null ? AIDCTStats.fromMap(json['status'] as JsonMap) : null,
        pluginCount: json['pluginCount'] as int,
      );
  final String name;
  final String type;
  final AIDCTStats? status;
  final int pluginCount;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'type': type,
        'status': status != null ? status!.toJson() : null,
        'pluginCount': pluginCount,
      };
  @override
  String toString() {
    return '''
{
  "name": "$name",
  "type": "$type",
  "status": ${status.toString().split('\n').map((String line) => '  $line').join('\n')},
  "pluginCount": $pluginCount
}''';
  }
}

class AIDCTStats {
  AIDCTStats({
    required this.flow,
    this.collecting,
    required this.idle,
    required this.fails,
    required this.log,
  });

  factory AIDCTStats.fromMap(Map<String, dynamic> json) => AIDCTStats(
        flow: json['flow'] as String,
        collecting: json['collecting'] != null
            ? List<String>.from((json['collecting'] as List<dynamic>).map((dynamic x) => x as String))
            : null,
        idle: (json['idle'] as num).toDouble(),
        fails: (json['fails'] as num).toDouble(),
        log: json['log'] as String,
      );

  final String flow;
  final List<String>? collecting;
  final double idle; // changed to double
  final double fails; // changed to double
  final String log;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'flow': flow,
        'collecting': collecting?.map((String x) => x).toList(),
        'idle': idle,
        'fails': fails,
        'log': log,
      };

  @override
  String toString() {
    return '''
{
  "flow": "$flow",
  "collecting": ${collecting == null ? 'null' : '["${collecting!.join('", "')}"]'},
  "idle": $idle,
  "fails": $fails,
  "log": "$log"
}''';
  }
}
