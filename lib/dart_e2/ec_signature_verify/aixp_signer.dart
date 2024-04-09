import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/aixp_verifier.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/ec_signature_verify.dart';

class AixpSigner {
  final ECPrivateKey privateKey;

  AixpSigner({required this.privateKey});
  ECPublicKey? publicKey;

  final _ecInstance = EcSignatureAndVerifier();

  String sign(String message) {
    try {
      String signature = _ecInstance.signHashToBase64(message, privateKey);
      return signature;
    } catch (e) {
      rethrow;
    }
  }

// Input: message string
// Perform: Sign a message string with our private key
// Returns: Base64 encoded hex signture
  Map<String, dynamic> signMessage(
    Map<String, dynamic> message,
    String addrress,
  ) {
    final cleanedMap = CustomJsonEncoder.cleanedAndRearrangedMap(message);
    var bytes = utf8.encode(jsonEncode(cleanedMap)); // Data being hashed
    var digest = sha256.convert(bytes);
    String hashHexEE = digest.toString();
    try {
      String signatureEE = _ecInstance.signHashToBase64(hashHexEE, privateKey);
      return CustomJsonEncoder.cleanedAndRearrangedMap({
        ...message,
        "EE_SIGN": signatureEE,
        "EE_HASH": hashHexEE,
        "EE_SENDER": addrress,
      });
    } catch (e) {
      rethrow;
    }
  }
}
