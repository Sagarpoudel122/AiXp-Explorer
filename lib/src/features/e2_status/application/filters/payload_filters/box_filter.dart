import 'package:e2_explorer/src/features/e2_status/application/filters/message_filter.dart';
import 'package:e2_explorer/src/features/e2_status/application/filters/payload_filters/pipeline_filter.dart';

class BoxFilter extends MessageFilter {
  BoxFilter({
    required super.name,
    required super.type,
    required this.children,
    required super.id,
    super.parent,
  });

  final List<PipelineFilter> children;

  BoxFilter copyWith({
    List<PipelineFilter>? children,
  }) {
    return BoxFilter(
      children: children ?? this.children,
      name: name,
      type: type,
      id: id,
    );
  }
}
