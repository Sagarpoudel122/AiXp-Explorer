import 'package:e2_explorer/dart_e2/models/payload/e2_payload.dart';
import 'package:intl/intl.dart';

class NotificationMessage {
  final Map<String, dynamic> payload;
  final DateTime localTimestamp;

  ///ToDO this is not ok
  final String filteringId;

  NotificationMessage({
    required this.payload,
    required this.localTimestamp,
    required this.filteringId,
  });

  @override
  String toString() {
    return 'NotificationMessage{filteringId: $filteringId}';
  }

  /// Create a NotificationMessage object from json
  /// it should have the following structure:
  /// boxName -> sender.hostId
  /// pipelineName -> data.identifiers.streamId
  /// pluginSignature -> type to uppercase
  /// timestamp -> data.time
  /// timezone -> data.specificValue.ee_timezone
  /// content -> the whole message

  factory NotificationMessage.fromNotifcationMap(Map<String, dynamic> payload) {
    final boxName = payload['EE_ID'];
    final pipelineName = payload['EE_PAYLOAD_PATH'][0];
    final pluginSignature = payload['EE_PAYLOAD_PATH'][1];
    final pluginInstanceName = payload['EE_PAYLOAD_PATH'][2];

    final localTimestamp =
        _parseLocalTimestamp(payload['EE_TIMESTAMP'], payload['EE_TIMEZONE']);

    return NotificationMessage(
      localTimestamp: localTimestamp,
      payload: payload,
      filteringId:
          '$boxName#$pipelineName#$pluginSignature#$pluginInstanceName',
    );
  }

  // factory NotificationMessage.fromMap(Map<String, dynamic> payloadMap) {
  //   final eePayloadPath = (payloadMap['EE_PAYLOAD_PATH'] as List).map((e) => e as String).toList();
  //
  //   final boxName = eePayloadPath[0];
  //   final pipelineName = eePayloadPath[1];
  //   final pluginSignature = eePayloadPath[2].toUpperCase();
  //   final pluginInstanceName = eePayloadPath[3];
  //
  //   // final timestamp = payloadMap['data'] != null ? payloadMap['data']['time'] : '2023-08-31 14:06:04.980345';
  //   final timestamp = payloadMap['data']['time'];
  //   // final timezone = payloadMap['data'] != null ?  payloadMap['data']['specificValue']['ee_timezone'] : 'UTC+3';
  //   final timezone = payloadMap['data']['specificValue']['ee_timezone'];
  //
  //   final content = payloadMap;
  //
  //   final localTimestamp = _parseLocalTimestamp(timestamp, timezone);
  //
  //   return NotificationMessage(
  //     boxName: boxName,
  //     pipelineName: pipelineName,
  //     pluginSignature: pluginSignature,
  //     pluginInstanceName: pluginInstanceName,
  //     timestamp: timestamp,
  //     timezone: timezone,
  //     localTimestamp: localTimestamp,
  //     content: content,
  //     filteringId: '$boxName#$pipelineName#$pluginSignature#$pluginInstanceName',
  //   );
  // }
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
