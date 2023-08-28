import 'package:e2_explorer/src/features/e2_status/application/filters/message_filter.dart';

class PluginInstanceFilter extends MessageFilter {
  PluginInstanceFilter({
    required super.name,
    required super.type,
    required super.id,
    super.parent,
  });
}
