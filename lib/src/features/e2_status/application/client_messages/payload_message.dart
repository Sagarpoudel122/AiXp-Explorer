import 'package:intl/intl.dart';

class PayloadMessage {
  final String boxName;
  final String pipelineName;
  final String pluginSignature;
  final String pluginInstanceName;
  final String timestamp;
  final String timezone;
  final DateTime localTimestamp;
  final Map<String, dynamic> content;

  ///ToDO this is not ok
  final String filteringId;

  PayloadMessage({
    required this.boxName,
    required this.pipelineName,
    required this.pluginSignature,
    required this.pluginInstanceName,
    required this.timestamp,
    required this.timezone,
    required this.localTimestamp,
    required this.content,
    required this.filteringId,
  });

  @override
  String toString() {
    return 'PayloadMessage{filteringId: $filteringId}';
  }

  /// ToDO: check if we need toMap function here
  // Map<String, dynamic> toMap() {
  //   return {
  //     'boxName': this.boxName,
  //     'pipelineName': this.pipelineName,
  //     'pluginSignature': this.pluginSignature,
  //     'timestamp': this.timestamp,
  //     'timezone': this.timezone,
  //     'localTimestamp': this.localTimestamp,
  //     'content': this.content,
  //   };
  // }

  /// Create a PayloadMessage object from json
  /// it should have the following structure:
  /// boxName -> sender.hostId
  /// pipelineName -> data.identifiers.streamId
  /// pluginSignature -> type to uppercase
  /// timestamp -> data.time
  /// timezone -> data.specificValue.ee_timezone
  /// content -> the whole message

  factory PayloadMessage.fromMap(Map<String, dynamic> payloadMap) {
    final eePayloadPath = (payloadMap['EE_PAYLOAD_PATH'] as List).map((e) => e as String).toList();

    final boxName = eePayloadPath[0];
    final pipelineName = eePayloadPath[1];
    final pluginSignature = eePayloadPath[2].toUpperCase();
    final pluginInstanceName = eePayloadPath[3];

    // final timestamp = payloadMap['data'] != null ? payloadMap['data']['time'] : '2023-08-31 14:06:04.980345';
    final timestamp = payloadMap['data']['time'];
    // final timezone = payloadMap['data'] != null ?  payloadMap['data']['specificValue']['ee_timezone'] : 'UTC+3';
    final timezone = payloadMap['data']['specificValue']['ee_timezone'];

    final content = payloadMap;

    final localTimestamp = _parseLocalTimestamp(timestamp, timezone);

    return PayloadMessage(
      boxName: boxName,
      pipelineName: pipelineName,
      pluginSignature: pluginSignature,
      pluginInstanceName: pluginInstanceName,
      timestamp: timestamp,
      timezone: timezone,
      localTimestamp: localTimestamp,
      content: content,
      filteringId: '$boxName#$pipelineName#$pluginSignature#$pluginInstanceName',
    );
  }
}

/// Used to concatenate timezone and timestamp in order to obtain the desired format
/// Had to modify because flutter only supports UTC+0 timezone
/// ToDO: reformat
DateTime _parseLocalTimestamp(String timestamp, String timezone) {
  final timestampWithTimezone = timestamp;
  final utcOffset = int.parse(timezone.substring(3));
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final dateTime = dateFormat.parseUtc(timestampWithTimezone.substring(0, 19));
  final dateTimeWithOffset = dateTime.copyWith(hour: dateTime.hour - utcOffset);
  final localDateTime = dateTimeWithOffset.toLocal();
  return localDateTime;
}
