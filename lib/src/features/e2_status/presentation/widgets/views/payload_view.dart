import 'package:e2_explorer/src/features/e2_status/application/client_messages/payload_message.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener_filters.dart';
import 'package:e2_explorer/src/features/e2_status/presentation/widgets/views/payload_message_view.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PayloadView extends StatefulWidget {
  const PayloadView({
    super.key,
    // required this.messagesByPipelines,
    required this.boxName,
  });

  // final Map<String, List<Map<String, dynamic>>> messagesByPipelines;
  final String boxName;

  @override
  State<PayloadView> createState() => _PayloadViewState();
}

class _PayloadViewState extends State<PayloadView> {
  final E2Client _client = E2Client();
  String? selectedPipelineName;
  PayloadMessage? _selectedMessage;

  // Map<String, List<Map<String, dynamic>>> messagesByPipelines = {};

  // final List<Map<String, dynamic>> filteredPipeline;

  List<String> pipelineFilter = [];
  List<String> pluginFilter = [];
  List<PayloadMessage> messages = [];

  /// ToDO: Remove this in the future
  List<Map<String, dynamic>> extractMapFromMessage(List<PayloadMessage> messages) {
    return messages.map((message) => message.content).toList();
  }

  void setSelectedMessage(PayloadMessage message) {
    _selectedMessage = message;
    // _selectedMessageText = const JsonEncoder.withIndent('    ').convert(message);
  }

  bool Function(PayloadMessage) filterMessagesByPipeline(String pipelineName) {
    return (PayloadMessage message) {
      return pipelineName == message.pipelineName;
    };
  }

  bool Function(PayloadMessage) filterMessagesByPipelines(List<String> pipelines) {
    return (PayloadMessage message) {
      return pipelines.contains(message.pipelineName);
    };
  }

  @override
  void initState() {
    super.initState();
    final box = _client.selectBoxByName(widget.boxName);
    messages = box!.payloadMessages;
    messages.sort(
      (a, b) => a.localTimestamp.compareTo(b.localTimestamp),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PayloadView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(builder: (context, setStateBuilder) {
            return E2Listener(
              onPayload: (message) {
                // if (messages.isEmpty) {
                //   final box = _client.selectBoxByName(widget.boxName);
                //   messages = box?.payloadMessages ?? [];
                // }
                // print('EEEEEE');

                /// ToDo:  find  a way to optimize and insert the element in the sorted list
                messages.sort(
                  (a, b) => a.localTimestamp.compareTo(b.localTimestamp),
                );
                setStateBuilder(() {});
              },
              dataFilter: E2ListenerFilters.filterByBox(widget.boxName),
              builder: (context) {
                return Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // if (selectedPipelineName != null)
                      // SizedBox(
                      //   height: 600,
                      //   width: 700,
                      //   child: FilterTreeView(
                      //     filters: _client.boxFilters.values.toList(),
                      //   ),
                      // ),
                      // FilterDropdown(filters: _client.boxFilters.values.toList()),
                      Expanded(
                        child: Column(
                          children: [
                            Flexible(
                              /// ToDO: Replace message list with a widget that can be further parametrized
                              // child: MessageList(
                              //     // messages: messagesByPipelines[selectedPipelineName] ?? [],
                              //     messages: pipelineFilter.isEmpty
                              //         ? extractMapFromMessage(messages)
                              //         : extractMapFromMessage(
                              //             messages.where(filterMessagesByPipelines(pipelineFilter)).toList(),
                              //           ),
                              //     selectedMessageId: _selectedMessage?.content['messageID'],
                              //     onTap: (int index, Map<String, dynamic> message) {
                              //       setState(() {
                              //         // setSelectedMessage(messagesByPipelines[selectedPipelineName]![index]);
                              //         setSelectedMessage(message);
                              //       });
                              //     }),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Disabled until next update',
                                    style: TextStyles.body(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      // else
                      //   const Center(
                      //     child: Text('No pipeline selected'),
                      //   ),
                    ],
                  ),
                );
              },
            );
          }),
          Expanded(
            flex: 5,
            child: PayloadMessageView(
              // key: ValueKey(_selectedMessage?['messageID']),
              selectedMessage: _selectedMessage,
            ),
          ),
        ],
      ),
    );
  }
}
