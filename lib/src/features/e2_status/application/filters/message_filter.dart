enum FilterType {
  pipelineFilter,
  pluginTypeFilter,
  pluginInstanceFilter,
  boxFilter,
}

class MessageFilter {
  MessageFilter({
    required this.name,
    required this.type,
    required this.id,
    this.parent,
  });

  final String name;
  final FilterType type;
  final String id;
  MessageFilter? parent;

  bool get hasParent => parent != null;

  void setParent(MessageFilter? parent) {
    this.parent = parent;
  }

  @override
  String toString() {
    return 'MessageFilter{name: $name, type: $type}';
  }
}
