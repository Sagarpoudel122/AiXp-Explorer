// import 'dart:convert';
//
// import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
// import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/hardware_info_view.dart';
// import 'package:e2_explorer/src/features/e2_status/utils/box_messages.dart';
// import 'package:e2_explorer/src/styles/color_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import 'box_messages_tab_display.dart';
//
// class BoxViewer extends StatefulWidget {
//   const BoxViewer({super.key, required this.boxName});
//
//   final String boxName;
//
//   @override
//   State<BoxViewer> createState() => _BoxViewerState();
// }
//
// class _BoxViewerState extends State<BoxViewer> {
//   Map<String, dynamic>? _selectedMessage;
//   String? _selectedMessageText;
//   BoxMessages? _boxMessages;
//   final client = E2Client();
//   int? _heartbeatListener;
//   int? _payloadListener;
//   int? _notificationsListener;
//
//   BoxViewerTab _currentTab = BoxViewerTab.values.first;
//
//   bool filterSelectedBox(data) {
//     final message = data as Map<String, dynamic>;
//     final boxName = E2Client.getBoxName(message);
//     return boxName == widget.boxName;
//   }
//
//   void _onTabChanged(BoxViewerTab tab) {
//     debugPrint('Tab changed: $tab');
//     _currentTab = tab;
//     handleTabChanged();
//   }
//
//   void handleTabChanged() {
//     removeTabListeners();
//     switch (_currentTab) {
//       case BoxViewerTab.pipelines:
//         addHeartBeatListener();
//         break;
//       case BoxViewerTab.hardwareInfo:
//         addHeartBeatListener();
//         break;
//       case BoxViewerTab.payload:
//         addPayloadListener();
//         break;
//       case BoxViewerTab.notification:
//         addNotificationListener();
//         break;
//       case BoxViewerTab.heartbeat:
//         addHeartBeatListener();
//         break;
//       case BoxViewerTab.fullPayload:
//         //TODO: Handle case
//         break;
//     }
//   }
//
//   void heartbeatListener(dynamic data) {
//     //debugPrint('Received new heartbeat for ${widget.boxName}');
//     if (_currentTab == BoxViewerTab.heartbeat || _currentTab == BoxViewerTab.hardwareInfo) {
//       setState(() {});
//     }
//   }
//
//   void payloadsListener(dynamic data) {
//     //debugPrint('Received new payload for ${widget.boxName}');
//     if (_currentTab == BoxViewerTab.payload) {
//       setState(() {});
//     }
//   }
//
//   void notificationsListener(dynamic data) {
//     //debugPrint('Received new notification for ${widget.boxName}');
//     if (_currentTab == BoxViewerTab.notification) {
//       setState(() {});
//     }
//   }
//
//   void removeTabListeners() {
//     if (_heartbeatListener != null) {
//       client.notifiers.heartbeats.removeListener(_heartbeatListener!);
//       _heartbeatListener = null;
//     }
//     if (_payloadListener != null) {
//       client.notifiers.payloads.removeListener(_payloadListener!);
//       _payloadListener = null;
//     }
//     if (_notificationsListener != null) {
//       client.notifiers.notifications.removeListener(_notificationsListener!);
//       _notificationsListener = null;
//     }
//   }
//
//   void addHeartBeatListener() {
//     _heartbeatListener = client.notifiers.heartbeats.addListener(filterSelectedBox, heartbeatListener);
//   }
//
//   void addPayloadListener() {
//     _payloadListener = client.notifiers.payloads.addListener(filterSelectedBox, payloadsListener);
//   }
//
//   void addNotificationListener() {
//     _notificationsListener = client.notifiers.notifications.addListener(filterSelectedBox, notificationsListener);
//   }
//
//   initForBox(String boxName) {
//     _boxMessages = client.boxMessages[widget.boxName];
//     _selectedMessage = null;
//     _selectedMessageText = null;
//     handleTabChanged();
//   }
//
//   void setSelectedMessage(Map<String, dynamic> message) {
//     _selectedMessage = message;
//     _selectedMessageText = const JsonEncoder.withIndent('    ').convert(message);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initForBox(widget.boxName);
//   }
//
//   @override
//   void didUpdateWidget(covariant BoxViewer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.boxName != widget.boxName) {
//       debugPrint('Selected new box: ${widget.boxName}');
//       initForBox(widget.boxName);
//     }
//   }
//
//   @override
//   void dispose() {
//     removeTabListeners();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xff161616),
//       height: double.infinity,
//       child: BoxMessagesTabDisplay(
//         onTabChanged: _onTabChanged,
//         // payloadView: PayloadView(
//         //   // key: ValueKey(widget.boxName),
//         //   messagesByPipelines: _boxMessages!.payloadMessagesByPipelines,
//         // ),
//         payloadView: Container(),
//         notificationView: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     final message = _boxMessages!.notificationMessages[index];
//
//                     return InkWell(
//                       //key: ValueKey(message['messageID']),
//                       onTap: () {
//                         setState(() {
//                           setSelectedMessage(message);
//                         });
//                       },
//                       child: Container(
//                         color: _selectedMessage?['messageID'] == message['messageID']
//                             ? const Color(0xff2A3A6F)
//                             : ColorStyles.dark800,
//                         height: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '${_boxMessages!.notificationMessages[index]['type']}',
//                                 style: const TextStyle(
//                                   color: Colors.white38,
//                                 ),
//                               ),
//                               Text(
//                                 DateFormat('hh:mm:ss').format(DateTime.parse(message['time']['hostTime'])),
//                                 style: const TextStyle(
//                                   color: Colors.white38,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   /*separatorBuilder: (context, index) {
//                     return const SizedBox(
//                       height: 4,
//                     );
//                   },*/
//                   itemCount: _boxMessages!.notificationMessages.length,
//                 ),
//               ),
//               const VerticalDivider(
//                 color: Colors.white10,
//               ),
//               Expanded(
//                 child: _selectedMessage != null
//                     ? Container(
//                         height: double.infinity,
//                         color: const Color(0xff161616),
//                         child: Column(
//                           children: <Widget>[
//                             Expanded(
//                               // child: JsonView.map(
//                               //   _selectedMessage!,
//                               //   theme: const JsonViewTheme(
//                               //     backgroundColor: ColorStyles.dark800,
//                               //   ),
//                               // ),
//                               child: SelectableText(
//                                 _selectedMessageText!,
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : const Center(
//                         child: Text(
//                           'No message selected',
//                           style: TextStyle(
//                             color: Colors.white38,
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//         heartbeatView: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     final message = _boxMessages!.heartbeatMessages[index];
//                     return InkWell(
//                       //key: ValueKey(message['messageID']),
//                       onTap: () {
//                         setState(() {
//                           setSelectedMessage(message);
//                         });
//                       },
//                       child: Container(
//                         color: message['messageID'] == _selectedMessage?['messageID']
//                             ? const Color(0xff2A3A6F)
//                             : ColorStyles.dark800,
//                         height: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '${_boxMessages!.heartbeatMessages[index]['type']}',
//                                 style: const TextStyle(
//                                   color: Colors.white38,
//                                 ),
//                               ),
//                               Text(
//                                 DateFormat('hh:mm:ss').format(DateTime.parse(message['time']['hostTime'])),
//                                 style: const TextStyle(
//                                   color: Colors.white38,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   /*separatorBuilder: (context, index) {
//                     return const SizedBox(
//                       height: 4,
//                     );
//                   },*/
//                   itemCount: _boxMessages!.heartbeatMessages.length,
//                 ),
//               ),
//               const VerticalDivider(
//                 color: Colors.white10,
//               ),
//               Expanded(
//                 child: _selectedMessage != null
//                     ? Container(
//                         height: double.infinity,
//                         width: double.infinity,
//                         color: const Color(0xff161616),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Expanded(
//                               // child: JsonView.map(
//                               //   _selectedMessage!,
//                               //   theme: const JsonViewTheme(
//                               //     backgroundColor: ColorStyles.dark800,
//                               //   ),
//                               // ),
//                               child: SelectableText(
//                                 _selectedMessageText!,
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : const Center(
//                         child: Text(
//                           'No message selected',
//                           style: TextStyle(
//                             color: Colors.white38,
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//         hardwareInfoView: HardwareInfoView(
//           key: ValueKey(widget.boxName),
//           boxName: widget.boxName,
//         ),
//         // hardwareInfoView: Container(),
//         pipelinesView: Container(),
//         // fullPayloadsView: Container(),
//         // pipelinesView: PipelineView(
//         //   currentHeartbeat: _boxMessages?.heartbeatDecodedMessages.firstOrNull,
//         //   currentHeartbeatMap: _boxMessages?.heartbeatMessages.firstOrNull,
//         // ),
//       ),
//     );
//   }
// }
