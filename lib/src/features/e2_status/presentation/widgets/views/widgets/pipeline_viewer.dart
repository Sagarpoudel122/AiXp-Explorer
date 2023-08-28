import 'package:e2_explorer/src/features/e2_status/presentation/widgets/messages/simple_message_viewer.dart';
import 'package:flutter/material.dart';

class PipelineViewer extends StatelessWidget {
  const PipelineViewer({super.key, required this.pipelineBody});

  final Map<String, dynamic> pipelineBody;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SimpleMessageViewer(
        message: pipelineBody,
      ),
    );
  }
}
