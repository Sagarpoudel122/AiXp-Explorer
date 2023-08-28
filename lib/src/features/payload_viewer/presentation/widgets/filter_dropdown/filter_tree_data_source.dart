import 'package:e2_explorer/src/features/common_widgets/hf_tree/index.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/message_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/box_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/pipeline_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/plugin_type_filter.dart';

class FilterTreeDataSource extends TreeDataSource<MessageFilter, String> {
  FilterTreeDataSource({required super.roots});

  @override
  Iterable<MessageFilter> getChildren(MessageFilter item) {
    switch (item.type) {
      case FilterType.pipelineFilter:
        return (item as PipelineFilter).children;
      case FilterType.pluginTypeFilter:
        return (item as PluginTypeFilter).children;
      case FilterType.pluginInstanceFilter:
        return [];
      case FilterType.boxFilter:
        return (item as BoxFilter).children;
    }
  }

  @override
  MessageFilter? getParent(MessageFilter item) {
    return item.parent;
  }

  @override
  bool hasChildren(MessageFilter item) {
    switch (item.type) {
      case FilterType.pipelineFilter:
        return (item as PipelineFilter).children.isNotEmpty;
      case FilterType.pluginTypeFilter:
        return (item as PluginTypeFilter).children.isNotEmpty;
      case FilterType.pluginInstanceFilter:
        return false;
      case FilterType.boxFilter:
        return (item as BoxFilter).children.isNotEmpty;
    }
  }

  @override
  String getUniqueID(MessageFilter item) {
    return item.id;
  }
}
