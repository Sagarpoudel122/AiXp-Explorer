import 'package:e2_explorer/src/features/e2_status/application/filters/message_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/plugin_type_filter.dart';

class PipelineFilter extends MessageFilter {
  PipelineFilter({
    required super.name,
    required super.type,
    required this.children,
    required super.id,
    super.parent,
  });

  PipelineFilter copyWith({
    List<PluginTypeFilter>? children,
  }) {
    return PipelineFilter(
      children: children ?? this.children,
      name: name,
      type: type,
      id: id,
    );
  }

  final List<PluginTypeFilter> children;
}
