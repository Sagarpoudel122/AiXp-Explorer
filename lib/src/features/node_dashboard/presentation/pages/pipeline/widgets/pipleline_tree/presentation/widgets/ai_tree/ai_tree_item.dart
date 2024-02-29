// ignore_for_file: public_member_api_docs, sort_constructors_first
part of ai;

typedef AITreeItem = TreeItem<String, AITreeValue<dynamic>>;
typedef AITreeNode = TreeNode<String, AITreeValue<dynamic>>;

enum AITreeValueType {
  pipelineGroup,
  pipeline,
  pluginInstance,
  pluginNewInstance,
  pluginTypeGroup,
  edgeDevice,
  location,
  camera,
  cameraStream,
  client,
}

sealed class AITreeValue<ValueType> {
  final AITreeValueType type;
  final ValueType data;

  AITreeValue({
    required this.type,
    required this.data,
  });
}

///
/// Selectable items are items that are displayed
/// in the right panel
///
sealed class AITreeValueSelectable<ValueType> extends AITreeValue<ValueType> {
  AITreeValueSelectable({
    required super.type,
    required super.data,
  });
}

class AITreePluginTypeGroup extends AITreeValue<String> {
  AITreePluginTypeGroup({
    required String name,
  }) : super(type: AITreeValueType.pluginTypeGroup, data: name);
}

class PipelineGroup {
  final String boxName;

  PipelineGroup({
    required this.boxName,
  });
}

class AITreePipelineGroup extends AITreeValue<PipelineGroup> {
  AITreePipelineGroup({
    required PipelineGroup pipelineGroup,
  }) : super(type: AITreeValueType.pipelineGroup, data: pipelineGroup);
}

class AITreeEdgeDevice extends AITreeValue<EquipmentDTO> {
  AITreeEdgeDevice({required EquipmentDTO equipment})
      : super(
          type: AITreeValueType.edgeDevice,
          data: equipment,
        );
}

class AITreeLocation extends AITreeValue<Location> {
  AITreeLocation({required Location location})
      : super(
          type: AITreeValueType.location,
          data: location,
        );
}

class AITreeClient extends AITreeValue<BusinessClient> {
  AITreeClient({required BusinessClient client})
      : super(
    type: AITreeValueType.client,
    data: client,
  );
}

class AITreeCamera extends AITreeValue<Equipment> {
  AITreeCamera({required Equipment camera})
      : super(
          type: AITreeValueType.camera,
          data: camera,
        );
}

class AITreeCameraStream extends AITreeValue<CameraStream> {
  AITreeCameraStream({required CameraStream stream})
      : super(
          type: AITreeValueType.cameraStream,
          data: stream,
        );
}

class AITreePipeline extends AITreeValueSelectable<AIPipeline> {
  AITreePipeline({
    required super.data,
  }) : super(type: AITreeValueType.pipeline);
}

class AITreePluginInstance extends AITreeValueSelectable<AIPluginInstanceData> {
  AITreePluginInstance({
    required super.data,
  }) : super(type: AITreeValueType.pluginInstance);
}

class AITreePluginNewInstance extends AITreeValueSelectable<AIPluginInstanceData> {
  AITreePluginNewInstance({
    required super.data,
    required this.onSaveSuccess,
  }) : super(type: AITreeValueType.pluginNewInstance);
  final void Function() onSaveSuccess;
}
