part of ai;

typedef AITreeController = TreeController<String, AITreeValue<dynamic>>;

class AITreeItems extends TreeItems<String, AITreeValue<dynamic>> {
  @override
  bool hasChildren({required AITreeItem item}) {
    if (item.value is AITreePipeline) {
      return (item.value as AITreePipeline).data.pluginCount > 0 || item.children.isNotEmpty;
    }
    return item.children.isNotEmpty;
  }

  @override
  String getItemCaption({required AITreeItem item}) {
    switch (item.value.type) {
      case AITreeValueType.pluginInstance:
        final AIPluginInstance instance = (item.value.data as AIPluginInstanceData).pluginInstance;
        return '${instance.name} - ${instance.signature}';
      case AITreeValueType.pipeline:
        final AIPipeline pipeline = item.value.data as AIPipeline;
        return '${pipeline.name} - ${pipeline.type}';
      case AITreeValueType.pipelineGroup:
        return 'Cameras';
      case AITreeValueType.pluginTypeGroup:
        return item.value.data as String;
      case AITreeValueType.edgeDevice:
        return (item.value.data as EquipmentDTO).name;
      case AITreeValueType.camera:
        return (item.value.data as Equipment).name;
      case AITreeValueType.location:
        return (item.value.data as Location).name;
      case AITreeValueType.client:
        return (item.value.data as BusinessClient).name;
      case AITreeValueType.cameraStream:
        return (item.value.data as CameraStream).name;
      case AITreeValueType.pluginNewInstance:
        final AIPluginInstance instance = (item.value.data as AIPluginInstanceData).pluginInstance;
        return '${instance.name} - ${instance.signature}';
    }
  }

  Future<void> addPluginInstanceChildren({
    required AITreeItem parent,
    required AITreePipeline pipeline,
    required List<AIPluginInstanceReference> pluginsList,
  }) async {
    await Future.forEach(pluginsList, (AIPluginInstanceReference plugin) async {
      final AIPluginInstanceDTO pluginInstanceDTO = await AIRepository().getPluginInstance(
        boxName: pipeline.data.boxName,
        pipelineName: pipeline.data.name,
        pluginInstanceName: plugin.name,
      );
      final AIPluginSchemaDTO pluginSchema =
          await AIRepository().getPluginSchemaForSignature(signature: pluginInstanceDTO.signature);
      final AIPluginInstance pluginInstance = AIPluginInstance.fromDTOAndSchema(
        boxName: pipeline.data.boxName,
        pipelineName: pipeline.data.name,
        dto: pluginInstanceDTO,
        schema: pluginSchema,
      );
      final TreeItem<String, AITreeValue<dynamic>>? clientTreeParent = parent.getAncestorByCondition(
        condition: (String key) => key.startsWith('client-'),
      );
      final AITreeClient? clientParent = clientTreeParent?.value as AITreeClient?;
      final AITreePluginInstance pluginInstanceValue = AITreePluginInstance(
        data: AIPluginInstanceData(
          // onUpdateSuccessful: () {
          //   parent.loadChildren();
          // },
          pluginInstance: pluginInstance,
          edgeUuid: (parent
                  .getAncestorByCondition(
                    condition: (String key) => key.startsWith('edgeDevice-'),
                  )!
                  .value as AITreeEdgeDevice)
              .data
              .uuid,
          clientUuid: clientParent?.data.uuid,
        ),
      );

      parent.addChild(pluginInstance.key, pluginInstanceValue);
    });
  }

  @override
  bool itemNeedsToLoadChildren({required AITreeItem item}) {
    if (item.value is AITreePipeline) {
      final AITreePipeline pipeline = item.value as AITreePipeline;
      return pipeline.data.pluginCount > 0 && item.children.isEmpty;
    }

    return item.hasChildren && item.children.isEmpty;
  }

  @override
  Future<void> loadChildren({required AITreeItem item}) async {
    if (item.value is AITreePipeline) {
      final AITreePipeline instance = item.value as AITreePipeline;
      final List<AIPluginInstanceReference> pluginInstances = await AIRepository().getPluginInstances(
        boxName: instance.data.boxName,
        pipelineName: instance.data.name,
      );
      await addPluginInstanceChildren(
        parent: item,
        pipeline: instance,
        pluginsList: pluginInstances,
      );
    }
  }
}
