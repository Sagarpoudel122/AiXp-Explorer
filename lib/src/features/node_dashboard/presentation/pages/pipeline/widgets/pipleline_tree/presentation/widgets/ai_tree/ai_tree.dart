part of ai;

class AITree extends StatefulWidget {
  const AITree({
    super.key,
    this.emptyStateBuilder,
    this.controller,
    this.onSelectionChanged,
    required this.isSuper,
  });

  final Widget Function(BuildContext context)? emptyStateBuilder;
  final AITreeController? controller;
  final bool isSuper;
  final void Function(
    AITreeValueSelectable<dynamic>? item,
  )? onSelectionChanged;

  @override
  State<AITree> createState() => _AITreeState();
}

Future<AITreeItems> createAITree({required bool isSuper}) async {
  final AITreeItems treeItems = AITreeItems();
  List<BusinessClient> clients = <BusinessClient>[];
  // final List<Location> locations =
  //     constLocation.map((e) => Location.fromMap(e)).toList();
  final List<Location> locations = locationconstantList;
  final Map<String, AITreeItem> locationsMap = <String, AITreeItem>{};
  final Map<String, AITreeItem> clientMap = <String, AITreeItem>{};

  /// Get and build clients in case of super user
  if (isSuper) {
    clients = user.map((e) => BusinessClient.fromMap(e)).toList();

    for (final BusinessClient client in clients) {
      final AITreeItem treeItem =
          treeItems.add('client-${client.uuid}', AITreeClient(client: client));
      clientMap[client.uuid] = treeItem;
    }

    /// Add locations as child of client
    for (final Location location in locations) {
      final AITreeItem? clientItem = location.client?.uuid != null
          ? clientMap[location.client!.uuid]
          : null;

      if (clientItem == null) {
        continue;
      }
      final AITreeItem locationTreeItem = clientItem.addChild(
        'location-${location.uuid}',
        AITreeLocation(location: location),
      );
      print("This is child item");
      print(clientItem);
      locationsMap[location.uuid] = locationTreeItem;
    }
  }

  /// Start with location as root if user is not super
  else {
    for (final Location location in locations) {
      final AITreeItem treeItem = treeItems.add(
          'location-${location.uuid}', AITreeLocation(location: location));
      locationsMap[location.uuid] = treeItem;
    }
  }

  /// Request and build edge devices based on the location
  final Iterable<EquipmentDTO> edgeDevices = equipmentDtoContastant;

  for (final EquipmentDTO edgeDevice in edgeDevices) {
    final AITreeItem? locationItem = locationsMap[edgeDevice.location.uuid];
    if (locationItem == null) {
      continue;
    }
    final AITreeItem edgeDeviceItem = locationItem.addChild(
      'edgeDevice-${edgeDevice.name}',
      AITreeEdgeDevice(equipment: edgeDevice),
    );

    final List<AIPipelineDTO> edgeDevicePipelines =
        await AIRepository().getPipelinesForBox(boxName: edgeDevice.name);

    final AITreeItem pipelinesGroup = edgeDeviceItem.addChild(
      '${edgeDevice.name}-pipelines',
      AITreePipelineGroup(
          pipelineGroup: PipelineGroup(boxName: edgeDevice.name)),
    );

    /// Find all instances for all pipelines and add them to the tree
    for (final AIPipelineDTO pipelineDTO in edgeDevicePipelines) {
      final AIPipeline pipeline =
          AIPipeline.fromDTO(boxName: edgeDevice.name, dto: pipelineDTO);
      pipelinesGroup.addChild(
          'pipeline-${pipeline.key}', AITreePipeline(data: pipeline));
    }
  }

  return treeItems;
}

class _AITreeState extends State<AITree> {
  late final AITreeController _treeController;

  Future<void> handleRefresh(AITreeItem item) async {
    debugPrint('handleRefresh for $item');
    item.clear();
    final bool itemWasExpanded = _treeController.isItemExpanded(item);
    if (itemWasExpanded) {
      _treeController.setItemExpanded(item, expanded: false);
    }
    _treeController
      ..setItemLoading(item, loading: true)
      ..rebuild();

    await item.loadChildren();
    _treeController.setItemLoading(item, loading: false);
    if (itemWasExpanded) {
      _treeController.setItemExpanded(item, expanded: true);
    }
    _treeController.rebuild();
  }

  // Future<void> handleAdd(AITreeItem item) async {
  //   debugPrint('Add for ${item.value}');
  //   switch (item.value.type) {
  //     case AITreeValueType.pipelineGroup:
  //       {
  //         final PipelineGroup pipelineGroup =
  //             (item.value as AITreePipelineGroup).data;

  //         bool createdPipeline = false;
  //         await AddPipelineDialog.show(
  //           context: context,
  //           boxName: pipelineGroup.boxName,
  //           onSubmit: (String pipelineName, String dctType,
  //               AIDCTValues values) async {
  //             // ignore: join_return_with_assignment
  //             createdPipeline = await AIRepository().createPipelineForBox(
  //               boxName: pipelineGroup.boxName,
  //               pipelineName: pipelineName,
  //               dctType: dctType,
  //               config: values,
  //             );
  //             return createdPipeline;
  //           },
  //         );
  //         if (createdPipeline) {
  //           await refreshTree();
  //           _treeController.expand(item);
  //         }
  //       }
  //     case AITreeValueType.cameraStream:
  //       {}
  //     case AITreeValueType.pipeline:
  //       {
  //         final AITreePipeline treePipeline = item.value as AITreePipeline;
  //         final AIPipeline treePipelineData = treePipeline.data;
  //         if (context.mounted) {
  //           await AddPluginDialog.show(
  //             pipeline: treePipelineData,
  //             context: context,
  //             onSubmit: (String pluginName, AIPluginType pluginType) async {
  //               final AIPluginSchemaDTO schema = await AIRepository()
  //                   .getPluginSchemaForSignature(
  //                       signature: pluginType.signature);
  //               final TreeItem<String, AITreeValue<dynamic>>? clientAncestor =
  //                   item.getAncestorByCondition(
  //                 condition: (String key) => key.startsWith('client-'),
  //               );
  //               final AITreeClient? clientAncestorCast =
  //                   clientAncestor?.value as AITreeClient?;

  //               final AIPluginInstance newPluginInstance = AIPluginInstance(
  //                 boxName: treePipelineData.boxName,
  //                 pipelineName: treePipelineData.name,
  //                 signature: pluginType.signature,
  //                 name: pluginName,
  //                 schema: schema,
  //                 config: <String, dynamic>{},
  //                 tags: <String, dynamic>{},
  //                 isDraft: true,
  //               );
  //               final AITreeItem addedChild = item.addChild(
  //                 newPluginInstance.name,
  //                 AITreePluginNewInstance(
  //                   data: AIPluginInstanceData(
  //                     pluginInstance: newPluginInstance,
  //                     edgeUuid: (item
  //                             .getAncestorByCondition(
  //                               condition: (String key) =>
  //                                   key.startsWith('edgeDevice-'),
  //                             )!
  //                             .value as AITreeEdgeDevice)
  //                         .data
  //                         .uuid,
  //                     clientUuid: clientAncestorCast?.data.uuid,
  //                   ),
  //                   onSaveSuccess: () async {
  //                     await handleRefresh(item);
  //                     final TreeItem<String, AITreeValue<dynamic>>?
  //                         newSelection = item.children.firstWhereOrNull(
  //                       (TreeItem<String, AITreeValue<dynamic>> element) =>
  //                           element.value is AITreePluginInstance &&
  //                           (element.value.data as AIPluginInstanceData)
  //                                   .pluginInstance
  //                                   .name ==
  //                               newPluginInstance.name,
  //                     );
  //                     if (newSelection != null) {
  //                       _treeController
  //                         ..expand(item)
  //                         ..selectItem(newSelection);
  //                     }
  //                   },
  //                 ),
  //               );
  //               _treeController
  //                 ..expand(item)
  //                 ..selectItem(addedChild);
  //               /*

  //             debugPrint('Add plugin with signature: ${pluginType.signature}');
  //             */
  //               //await AIRepository().createPluginInstance()
  //               return true; //canClose
  //             },
  //           );
  //         }
  //         _treeController.rebuild();
  //       }
  //     case AITreeValueType.pluginNewInstance:
  //     case AITreeValueType.pluginInstance:
  //     case AITreeValueType.pluginTypeGroup:
  //     case AITreeValueType.edgeDevice:
  //     case AITreeValueType.location:
  //     case AITreeValueType.camera:
  //     case AITreeValueType.client:
  //       {}
  //   }
  // }

  // Future<void> handleDelete(
  //     AITreeItem item, OverlayController parentOverlay) async {
  //   switch (item.value.type) {
  //     case AITreeValueType.pipeline:
  //       {
  //         debugPrint('Delete for pipeline $item');
  //         final AIPipeline pipeline = item.value.data as AIPipeline;
  //         final (int result, bool success) =
  //             await AIRepository().getAffectedInstancesCountByHostPipeline(
  //           host: pipeline.boxName,
  //           pipeline: pipeline.name,
  //         );
  //         // print(result);
  //         // print(success);
  //         final bool? shouldDelete = await showDeleteModal(
  //           context: context,
  //           parentOverlay: parentOverlay,
  //           title: 'Delete pipeline',
  //           initialValue: pipeline.name,
  //           offset: const Offset(0, -37),
  //           customModalMessage: success && result > 0
  //               ? 'There ${result == 1 ? 'is' : 'are'} $result AI Plugin${result > 1 ? 's' : ''} affected by the removal of this pipeline.\nAre you sure you want to delete ${pipeline.name}?'
  //               : null,
  //         );
  //         if (shouldDelete ?? false) {
  //           _treeController
  //             ..setItemLoading(item, loading: true)
  //             ..rebuild();
  //           final bool isDeleteSuccessful = await AIRepository().deletePipeline(
  //             boxName: pipeline.boxName,
  //             pipelineName: pipeline.name,
  //             force: true,
  //           );

  //           if (context.mounted) {
  //             _treeController
  //               ..setItemLoading(item, loading: false)
  //               ..rebuild();
  //           }

  //           if (isDeleteSuccessful) {
  //             item.delete();
  //             if (context.mounted) {
  //               _treeController.rebuild();
  //             }
  //           }
  //         }
  //       }
  //     case AITreeValueType.pluginInstance:
  //       {
  //         debugPrint('Delete for plugin instance $item');
  //         final AIPluginInstance pluginInstance =
  //             (item.value.data as AIPluginInstanceData).pluginInstance;
  //         final bool? shouldDelete = await showDeleteModal(
  //           context: context,
  //           parentOverlay: parentOverlay,
  //           title: 'Delete plugin instance',
  //           initialValue: pluginInstance.name,
  //           offset: const Offset(0, -37),
  //         );
  //         if (shouldDelete ?? false) {
  //           _treeController
  //             ..setItemLoading(item, loading: true)
  //             ..rebuild();
  //           bool isDeleteSuccessful = true;
  //           if (!pluginInstance.isDraft) {
  //             isDeleteSuccessful = await AIRepository().deletePluginInstance(
  //               boxName: pluginInstance.boxName,
  //               pipelineName: pluginInstance.pipelineName,
  //               instanceID: pluginInstance.name,
  //             );
  //           }
  //           _treeController
  //             ..setItemLoading(item, loading: false)
  //             ..rebuild();

  //           if (isDeleteSuccessful) {
  //             final TreeItem<String, AITreeValue<dynamic>>? parent =
  //                 item.parent;
  //             item.delete();
  //             if (parent != null) {
  //               _treeController
  //                 ..selectItem(parent)
  //                 ..deselectItem(parent);
  //             }
  //             _treeController.rebuild();
  //           }
  //         }
  //       }
  //     case AITreeValueType.pluginTypeGroup:
  //     case AITreeValueType.pipelineGroup:
  //     case AITreeValueType.edgeDevice:
  //     case AITreeValueType.camera:
  //     case AITreeValueType.cameraStream:
  //     case AITreeValueType.location:
  //     case AITreeValueType.client:
  //       debugPrint('Delete for $item');
  //     case AITreeValueType.pluginNewInstance:
  //       {
  //         final TreeItem<String, AITreeValue<dynamic>>? parent = item.parent;
  //         item.delete();
  //         if (parent != null) {
  //           _treeController
  //             ..selectItem(parent)
  //             ..deselectItem(parent);
  //         }
  //         _treeController.rebuild();
  //       }
  //   }
  // }

  List<Widget> _buttonsBuilder(AITreeItem item) {
    final bool showAdd = <AITreeValueType>[
      // AITreeValueType.pipelineGroup,
      AITreeValueType.pipeline,
      AITreeValueType.cameraStream,
    ].contains(item.value.type);
    final bool showRefresh = <AITreeValueType>[
      AITreeValueType.pipeline,
    ].contains(item.value.type);

    return <Widget>[
      if (showRefresh)
        AITreeItemButton(
          icon: CarbonIcons.renew,
          onTap: () => handleRefresh(item),
        ),
      if (showAdd)
        AITreeItemButton(
          icon: Icons.add,
          onTap: () {
            // handleAdd(item);
          },
        ),
    ];
  }

  IconData getIcon(AITreeItem item) {
    switch (item.value.type) {
      case AITreeValueType.location:
        return CarbonIcons.map;
      case AITreeValueType.edgeDevice:
        // return HFIcons.edgeDeviceIcon;
        return CarbonIcons.map;

      case AITreeValueType.camera:
        return CarbonIcons.arrival;
      case AITreeValueType.cameraStream:
        return CarbonIcons.map;
      // return HFIcons.cameraIcon;
      case AITreeValueType.pipeline:
        return CarbonIcons.map;
      // return HFIcons.cameraIcon;
      case AITreeValueType.pluginInstance:
        return CarbonIcons.play;
      case AITreeValueType.pipelineGroup:
      case AITreeValueType.pluginTypeGroup:
        return CarbonIcons.folder;
      case AITreeValueType.pluginNewInstance:
        return CarbonIcons.pause;
      case AITreeValueType.client:
        return CarbonIcons.user;
    }
  }

  bool _showMenu(AITreeItem item) {
    if (<AITreeValueType>[
      AITreeValueType.pipeline,
      AITreeValueType.pluginInstance,
    ].contains(item.value.type)) {
      return true;
    }
    return false;
  }

  List<BaseMenuItem> getMenuItems(
      AITreeItem item, OverlayController parentOverlay) {
    final List<BaseMenuItem> result = <BaseMenuItem>[];
    if (item.value.type == AITreeValueType.pluginInstance) {
      final AITreePluginInstance pluginInstance =
          item.value as AITreePluginInstance;
      result.add(
        MenuOptionItem(
          onTap: () async {
            if (context.mounted) {
              // await WitnessViewerWidget.showDialog(
              //   context: context,
              //   node: pluginInstance.data.pluginInstance.boxName,
              //   pipeline: pluginInstance.data.pluginInstance.pipelineName,
              //   instance: pluginInstance.data.pluginInstance.name,
              // );
            }
            // print(result);
          },
          child: const Text('Show last witness'),
          leading: const Icon(CarbonIcons.view),
          // color: HFColors.red,
        ),
      );
      // Todo(Theo): Remove hardcoding here
      if (<String>[
        'CAMERA_TAMPERING_ANGLE_01',
        'CAMERA_TAMPERING_IQA_FAST_01',
        'CAMERA_TAMPERING_IQA_SLOW_01',
        'CAMERA_TAMPERING_BASIC_01',
        'PLANOGRAM_S1',
      ].contains(pluginInstance.data.pluginInstance.signature)) {
        result.add(
          MenuOptionItem(
            onTap: () async {},
            child: const Text('Reset Anchors'),
            leading: const Icon(CarbonIcons.harbor),
            // color: HFColors.red,
          ),
        );
      }
    }
    if (<AITreeValueType>[
      AITreeValueType.pipeline,
      AITreeValueType.pluginInstance,
    ].contains(item.value.type)) {
      result.add(
        MenuOptionItem(
          onTap: () async {
            // await handleDelete(item, parentOverlay);
          },
          child: Text("AppStrings.delete.translate(context)"),
          leading: const Icon(CarbonIcons.delete),
          color: Colors.red,
        ),
      );
    }
    return result;
  }

  bool _isLoading = true;

  Future<void> refreshTree() async {
    final TreeItems<String, AITreeValue<dynamic>> treeItems =
        await createAITree(isSuper: widget.isSuper);
    _treeController.items = treeItems;
  }

  @override
  void initState() {
    super.initState();

    () async {
      _treeController = widget.controller ??
          AITreeController(
            onSelectionChanged: (TreeItem<String, AITreeValue<dynamic>> item,
                {String? oldItem}) async {
              if (oldItem != null) {
                final TreeItem<String, AITreeValue<dynamic>>? parent =
                    item.parent;
                if (parent != null) {
                  final TreeItem<String, AITreeValue<dynamic>>?
                      oldItemTreeValue = parent.children.firstWhereOrNull(
                          (TreeItem<String, AITreeValue<dynamic>> element) =>
                              element.value is AITreePluginNewInstance &&
                              element.key == oldItem);
                  if (oldItemTreeValue != null) {
                    // final bool? confirmationResult =
                    //     await DialogUtils.showModalOverlay<bool>(
                    //   context: context,
                    //   title: 'Confirmation',
                    //   content:
                    //       'This plugin has not been saved! Selecting another plugin will discard all changes!',
                    //   icon: CarbonIcons.warning_hex,
                    // );
                    final bool? confirmationResult = false;

                    if (confirmationResult ?? false) {
                      if (mounted) {
                        oldItemTreeValue.delete();
                        _treeController.rebuild();
                      }
                      if (item.value is AITreeValueSelectable<dynamic>) {
                        widget.onSelectionChanged?.call(
                            item.value as AITreeValueSelectable<dynamic>);
                      } else {
                        widget.onSelectionChanged?.call(null);
                      }
                    } else {
                      _treeController
                        ..selectItem(oldItemTreeValue)
                        ..rebuild();
                    }
                  } else {
                    if (item.value is AITreeValueSelectable<dynamic>) {
                      widget.onSelectionChanged
                          ?.call(item.value as AITreeValueSelectable<dynamic>);
                    } else {
                      widget.onSelectionChanged?.call(null);
                    }
                  }
                }
              } else {
                if (item.value is AITreeValueSelectable<dynamic>) {
                  widget.onSelectionChanged
                      ?.call(item.value as AITreeValueSelectable<dynamic>);
                } else {
                  widget.onSelectionChanged?.call(null);
                }
              }
            },
          );
      await refreshTree();
      setState(() {
        _isLoading = false;
      });
    }.call();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _treeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TreeView<String, AITreeValue<dynamic>>(
            shrinkWrap: true,
            treeController: _treeController,
            nodeBuilder: (_, AITreeNode node) {
              final bool showMenu = _showMenu(node.item);
              return OverlayParent(
                name: node.item.caption,
                builder:
                    (BuildContext context, OverlayController parentOverlay) {
                  return AITreeItemWidget(
                    buttonsBuilder: _buttonsBuilder,
                    iconData: getIcon(node.item),
                    node: node,
                    controller: _treeController,
                    showMenu: showMenu,
                    canBeSelected: <AITreeValueType>[
                      AITreeValueType.pipeline,
                      AITreeValueType.pluginInstance
                    ].contains(node.item.value.type),
                    menuItems: getMenuItems(node.item, parentOverlay),
                  );
                },
              );
            },
            emptyStateBuilder: (widget.emptyStateBuilder != null)
                ? widget.emptyStateBuilder!
                : (_) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'No tree items',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.small14regular(
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    );
                  },
            padding: const EdgeInsets.all(4),
            duration: const Duration(milliseconds: 180),
          ),
        ],
      ),
    );
  }
}
