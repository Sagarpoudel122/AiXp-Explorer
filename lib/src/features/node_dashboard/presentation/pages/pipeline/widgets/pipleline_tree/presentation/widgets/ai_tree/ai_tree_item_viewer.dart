// part of ai;

// class AITreeItemViewer extends StatefulWidget {
//   const AITreeItemViewer({
//     super.key,
//     required this.item,
//     this.onPluginInstanceSaveSuccessful,
//   });

//   final AITreeValueSelectable<dynamic> item;
//   final void Function()? onPluginInstanceSaveSuccessful;
//   @override
//   State<AITreeItemViewer> createState() => _AITreeItemViewerState();
// }

// (String boxName, String pipelineName) getNames(AITreeValueSelectable<dynamic> item) {
//   final String boxName = switch (item) {
//     AITreePipeline(data: final AIPipeline pipeline) => pipeline.boxName,
//     AITreePluginInstance(data: final AIPluginInstanceData pluginInstanceData) => pluginInstanceData.pluginInstance.boxName,
//     AITreeCameraStream(data: final CameraStream cameraStream) => cameraStream.boxName,
//     AITreePluginNewInstance(data: final AIPluginInstanceData pluginInstanceData) => pluginInstanceData.pluginInstance.boxName,
//     // TODO: Handle this case.
//   };
//   final String pipelineName = switch (item) {
//     AITreePipeline(data: final AIPipeline pipeline) => pipeline.name,
//     AITreePluginInstance(data: final AIPluginInstanceData pluginInstanceData) => pluginInstanceData.pluginInstance.pipelineName,
//     AITreeCameraStream(data: final CameraStream cameraStream) => cameraStream.boxName,
//     AITreePluginNewInstance(data: final AIPluginInstanceData pluginInstanceData) => pluginInstanceData.pluginInstance.pipelineName,
//   };
//   return (boxName, pipelineName);
// }

// bool isSamePipeline(AITreeValueSelectable<dynamic> item1, AITreeValueSelectable<dynamic> item2) {
//   final (String boxName1, String pipelineName1) = getNames(item1);
//   final (String boxName2, String pipelineName2) = getNames(item2);
//   return boxName1 == boxName2 && pipelineName1 == pipelineName2;
// }

// class _AITreeItemViewerState extends State<AITreeItemViewer> {
//   late AITreeValueSelectable<dynamic> _currentItem = widget.item;
//   late String _currentBoxName;
//   late String _currentPipelineName;
//   AIDCTSnapshot? _snapshot;
//   bool _isLoadingSnapshot = true;

//   @override
//   void initState() {
//     super.initState();
//     updateNames();
//     updateSnapshot();
//   }

//   void updateNames() {
//     final (String boxName, String pipelineName) = getNames(_currentItem);
//     _currentBoxName = boxName;
//     _currentPipelineName = pipelineName;
//   }

//   Future<void> updateSnapshot() async {
//     setState(() {
//       _isLoadingSnapshot = true;
//       _snapshot = null;
//     });
//     _snapshot = null;
//     debugPrint('Requesting snapshot for box: $_currentBoxName, pipeline: $_currentPipelineName');
//     final AIDCTSnapshot? snapshot =
//         await AIRepository().getPipelineSnapshot(boxName: _currentBoxName, pipelineName: _currentPipelineName);
//     if (context.mounted) {
//       setState(() {
//         _isLoadingSnapshot = false;
//         _snapshot = snapshot;
//       });
//     }
//   }

//   @override
//   void didUpdateWidget(covariant AITreeItemViewer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.item != oldWidget.item) {
//       _currentItem = widget.item;
//       if (!isSamePipeline(oldWidget.item, widget.item)) {
//         updateNames();
//         updateSnapshot();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoadingSnapshot) {
//       return Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Requesting snapshot for box: $_currentBoxName, pipeline: $_currentPipelineName'),
//             const SizedBox(height: 20),
//             const CircularProgressIndicator(),
//             // const SizedBox(height: 300),
//           ],
//         ),
//       );
//     }
//     return switch (widget.item) {
//       AITreePipeline(data: final AIPipeline pipeline) => Column(
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//               child: Center(
//                 child: Text('Pipeline - ${pipeline.name}'),
//               ),
//             ),
//             if (_snapshot != null) Center(child: Image.memory(_snapshot!.image!)),
//           ],
//         ),
//       AITreePluginInstance(
//         data: final AIPluginInstanceData instanceData
//       ) => /*Center(
//           child: Text('Plugin - ${instance.name}'),
//         ),*/
//         BlocProvider<MediaSnapshotBloc>(
//           create: (BuildContext context) => MediaSnapshotBloc(
//             boxName: _currentBoxName,
//             pipelineName: _currentPipelineName,
//             snapshot: _snapshot!,
//           ),
//           child: PluginViewer(
//             pluginInstanceData: instanceData,
//             snapshot: _snapshot!,
//             onSaveSuccessful: widget.onPluginInstanceSaveSuccessful,
//           ),
//         ),
//       AITreePluginNewInstance(data: final AIPluginInstanceData instanceData) => BlocProvider<MediaSnapshotBloc>(
//           create: (BuildContext context) => MediaSnapshotBloc(
//             boxName: _currentBoxName,
//             pipelineName: _currentPipelineName,
//             snapshot: _snapshot!,
//           ),
//           child: PluginViewer(
//             pluginInstanceData: instanceData,
//             snapshot: _snapshot!,
//             onSaveSuccessful: widget.onPluginInstanceSaveSuccessful,
//           ),
//         ),
//     };
//   }
// }
