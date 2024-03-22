import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/ec_signature_verify.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/utils.dart';
import 'package:crypto/crypto.dart';

class AixpEnscryption {
  final ECPrivateKey privateKey;
  AixpEnscryption({
    required this.privateKey,
  });
  ECPublicKey? publicKey;

  final _ecInstance = EcSignatureAndVerifier();

// Input: message string
// Perform: Sign a message string with our private key
// Returns: Base64 encoded hex signture
  String signMessage(String message) {
    try {
      String signature = _ecInstance.signHashToBase64(message, privateKey!);
      return signature;
    } catch (e) {
      rethrow;
    }
  }

// Input: message string
// Perform: Sign a message string with our private key
// Returns: Base64 encoded hex signture
  bool verifyMessage(String jsonString) {
    Map<String, dynamic> decoded = jsonDecode(jsonString);
    var eeSign = urlSafeBase64ToBase64(decoded["EE_SIGN"]);
    var eeSender = decoded["EE_SENDER"];
    var eeHash = decoded["EE_HASH"];

    String sender =
        urlSafeBase64ToBase64(eeSender.replaceFirst(ADDR_PREFIX, ''));
    Uint8List publicKeyBytes = base64.decode(sender);
    ECPublicKey publicKey = _ecInstance.loadPublicKey(publicKeyBytes);

    decoded.remove("EE_SIGN");
    decoded.remove("EE_SENDER");
    decoded.remove("EE_HASH");

    String objData = deterministicJsonEncode(decoded);
    var bytes = utf8.encode(objData); // Data being hashed
    var digest = sha256.convert(bytes);

    if (eeHash == digest) {
      String hashHex = digest.toString();
      //Verify Signature with messaged hash
      bool isVerified = _ecInstance.verifySignature(eeSign, eeHash, publicKey);
      if (isVerified) {
        //Verify Signature with messaged hash
        isVerified = _ecInstance.verifySignature(
          eeSign,
          hashHex,
          publicKey,
        );
        return isVerified;
      }
    }
    return false;
  }
}
