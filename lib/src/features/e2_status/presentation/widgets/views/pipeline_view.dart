/// ToDO remove or decide if its worth to keep

// import 'dart:convert';
//
// import 'package:collection/collection.dart';
// import 'package:e2_explorer/dart_e2/models/utils_models/e2_heartbeat.dart';
// import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
// import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
// import 'package:e2_explorer/src/features/e2_status/application/e2_listener_filters.dart';
// import 'package:e2_explorer/src/styles/color_styles.dart';
// import 'package:flutter/material.dart';
//
// class PipelineView extends StatefulWidget {
//   const PipelineView({
//     super.key,
//     required this.boxName,
//   });
//
//   final String boxName;
//
//   @override
//   State<PipelineView> createState() => _PipelineViewState();
// }
//
// class _PipelineViewState extends State<PipelineView> {
//   final E2Client _client = E2Client();
//
//   String? selectedPipelineName;
//   String? selectedPipelineType;
//
//   E2Heartbeat? currentHeartbeat;
//   Map<String, dynamic>? currentHeartbeatMap;
//
//   @override
//   void initState() {
//     super.initState();
//     currentHeartbeat = _client.boxMessages[widget.boxName]?.heartbeatDecodedMessages.lastOrNull;
//     currentHeartbeatMap = _client.boxMessages[widget.boxName]?.heartbeatMessages.lastOrNull;
//   }
//
//   @override
//   void didUpdateWidget(PipelineView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // if (oldWidget.currentHeartbeatMap != widget.currentHeartbeatMap) {
//     //   selectedPipelineName = null;
//     //   selectedPipelineType = null;
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return E2Listener(
//       onHeartbeat: (data) {
//         setState(() {
//           currentHeartbeat = _client.boxMessages[widget.boxName]?.heartbeatDecodedMessages.lastOrNull;
//           currentHeartbeatMap = _client.boxMessages[widget.boxName]?.heartbeatMessages.lastOrNull;
//         });
//       },
//       dataFilter: E2ListenerFilters.filterByBox(widget.boxName),
//       builder: (context) {
//         if (currentHeartbeat == null) {
//           return const Center(
//             child: Text(
//               'No heartbeat received',
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         }
//         final pipelines = currentHeartbeat!.configPipelines.allPipelines;
//         final pipelinesMapList =
//             (currentHeartbeatMap!['metadata']['config_streams'] as List).map((e) => e as Map<String, dynamic>).toList();
//         return Container(
//           width: double.infinity,
//           color: const Color(0xff161616),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         //key: ValueKey(message['messageID']),
//                         onTap: () {
//                           setState(() {
//                             selectedPipelineName = pipelines[index].name;
//                             selectedPipelineType = pipelines[index].type;
//                           });
//                         },
//                         child: Container(
//                           color: selectedPipelineName == pipelines[index].name &&
//                                   selectedPipelineType == pipelines[index].type
//                               ? const Color(0xff2A3A6F)
//                               : ColorStyles.dark800,
//                           height: 30,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   pipelines[index].name,
//                                   style: const TextStyle(
//                                     color: Colors.white38,
//                                   ),
//                                 ),
//                                 Text(
//                                   pipelines[index].type,
//                                   style: const TextStyle(
//                                     color: Colors.white38,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: pipelines.length,
//                   ),
//                 ),
//                 const VerticalDivider(
//                   color: Colors.white10,
//                 ),
//                 Expanded(
//                   child: selectedPipelineName != null && selectedPipelineType != null
//                       ? Container(
//                           height: double.infinity,
//                           color: const Color(0xff161616),
//                           child: Column(
//                             children: <Widget>[
//                               Expanded(
//                                 child: SelectableText(
//                                   const JsonEncoder.withIndent('    ').convert(
//                                       pipelinesMapList.firstWhere((map) => map['NAME'] == selectedPipelineName)),
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const Center(
//                           child: Text(
//                             'No pipeline selected',
//                             style: TextStyle(
//                               color: Colors.white38,
//                             ),
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
