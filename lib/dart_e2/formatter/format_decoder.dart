import 'package:e2_explorer/dart_e2/formatter/cavi2_decoder.dart';

abstract class MqttMessageEncoderDecoder {
  /// returns a raw format after decoding
  Map<String, dynamic> decode(Map<String, dynamic> encoded);

  /// returns a formatted message after encoding
  Map<String, dynamic> encoder(Map<String, dynamic> decoded);

  /// returns a raw format after decoding based on the EE_FORMATTER,
  /// if EE_FORMATTER is not present, it returns the raw format
  /// if [decoder] is provided, it uses the provided decoder
  /// [decoder] is useful when you want to decode a message with a different format
  static Map<String, dynamic> raw(
    Map<String, dynamic> message, {
    MqttMessageEncoderDecoder? decoder,
  }) {
    if (decoder != null) {
      return decoder.decode(message);
    }

    switch (message['EE_FORMATTER']) {
      case 'cavi2':
        return Cavi2MessageEncoderDecoder().decode(message);
      case 'raw':
      case null:
        return message;
      default:
        throw FormatException(
            'EE_FORMATTER is invalid for the message with path: ${message['EE_PAYLOAD_PATH']}');
    }
  }
}
