class PipelineStatus {
  final String pipelineName;
  final List<PluginStatus> plugins;

  PipelineStatus({
    required this.pipelineName,
    required this.plugins,
  });

  @override
  String toString() {
    return 'PipelineStatus{pipelineName: $pipelineName, plugins: $plugins}';
  }
}

class PluginStatus {
  final String pluginSignature;
  final List<InstanceStatus> instances;

  PluginStatus({
    required this.pluginSignature,
    required this.instances,
  });

  @override
  String toString() {
    return 'PluginStatus{pluginSignature: $pluginSignature, instances: $instances}';
  }
}

class InstanceStatus {
  final String instanceName;

  InstanceStatus({
    required this.instanceName,
  });

  @override
  String toString() {
    return 'InstanceStatus{instanceName: $instanceName}';
  }
}
