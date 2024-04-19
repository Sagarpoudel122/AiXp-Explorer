import 'dart:convert';
import 'dart:io';
import 'dart:math';

class XpandUtils {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  static Map<String, dynamic> decodeEncryptedGzipMessage(String base64Message) {
    final bytes = base64Decode(base64Message);
    final decodedBytes = ZLibCodec().decoder.convert(bytes);
    final decodedData = utf8.decode(decodedBytes, allowMalformed: true);
    return jsonDecode(decodedData) as Map<String, dynamic>;
  }

  static String encodeEncryptedGzipMessage(Map<String, dynamic> base64Message) {
    final prettyprint = jsonEncode(base64Message);
    final bytes = utf8.encode(prettyprint);
    final decodedBytes = ZLibCodec().encoder.convert(bytes);
    return base64.encode(decodedBytes);
  }
}
