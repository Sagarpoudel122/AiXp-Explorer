enum TopicMessageType { payload, notification, heartbeat }

class TopicMessage {
  TopicMessage({required this.message, required TopicMessageType messageType})
      : typeDisplay = _typeToString(messageType);

  final String typeDisplay;
  final Map<String, dynamic> message;
}

String _typeToString(TopicMessageType type) {
  switch (type) {
    case TopicMessageType.payload:
      return 'payload';
    case TopicMessageType.notification:
      return 'notification';
    case TopicMessageType.heartbeat:
      return 'heartbeat';
  }
}
