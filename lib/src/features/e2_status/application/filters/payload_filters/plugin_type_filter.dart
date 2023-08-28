import 'package:e2_explorer/src/features/e2_status/application/filters/message_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/plugin_instance_filter.dart';

class PluginTypeFilter extends MessageFilter {
  PluginTypeFilter({
    required super.name,
    required super.type,
    required this.children,
    required super.id,
    super.parent,
  });

  PluginTypeFilter copyWith({
    List<PluginInstanceFilter>? children,
  }) {
    return PluginTypeFilter(
      children: children ?? this.children,
      name: name,
      type: type,
      id: id,
    );
  }

  final List<PluginInstanceFilter> children;
}
