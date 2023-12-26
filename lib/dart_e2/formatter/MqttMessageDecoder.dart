// import 'package:e2_explorer/dart_e2/formatter/cavi2_formatter.dart';
// import 'package:e2_explorer/dart_e2/formatter/models/cavi2_message.dart';
// import 'package:e2_explorer/dart_e2/models/e2_message.dart';
//
// class MqttMessageDecoder {
//   static E2Message decodeMqttMessage(Map<String, dynamic> map) {
//     final formatter = map['EE_FORMATTER'];
//     if (formatter == 'cavi2') {
//       final cavi2Message = Cavi2Message.fromMap(map);
//       return Cavi2Formatter.cavi2ToRaw(cavi2Message);
//     } else {
//       return E2Message.fromMap(map);
//     }
//   }
// }
