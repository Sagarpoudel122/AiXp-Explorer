import 'package:basic_utils/basic_utils.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/ec_signature_verify.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/encryption_aes.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/utils.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AixpWallet {
  final bool isDebug;
  AixpWallet({this.isDebug = false});

  static const privateKeySharedRef = 'wallet_privatekey';

  final ecHeaderPrefixForDer = "3056301006072a8648ce3d020106052b8104000a034200";
  final _ecInstance = EcSignatureAndVerifier();

  ECPrivateKey? privateKey;
  ECPublicKey? publicKey;

  /// ECPrivateKey to Hex
  String get privateKeyHex {
    return privateKey!.d!.toRadixString(16).padLeft(64, '0');
  }

  /// ECPublicKey to CompressedHex
  String get publicKeyHexCompressed =>
      _ecInstance.compressPublicKey(publicKey!);

  ///Wallet Address From Public Key
  String get walletAddress => _ecInstance.getAddressFromPublicKey(publicKey!);

  String get addressToShow {
    return minimfyAdddressToShow(walletAddress);
  }

  Future createWallet(String password) async {
    try {
      print("----- Create Wallet------");
      var keyPair = _ecInstance.generateSecp256k1KeyPair();
      privateKey = keyPair.privateKey as ECPrivateKey;
      publicKey = keyPair.publicKey as ECPublicKey;
      await _saveData(password);
    } catch (e) {
      rethrow;
    }
  }

  checkInitialRoute(BuildContext context) async {
    String? privateKeyData = await _getData();
    if (privateKeyData != null) {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteNames.walletPassword);
    } else {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteNames.walletPage);
    }
  }

  consoleKeyInfo() {
    if (isDebug) {
      final publicKeyCompredHex = _ecInstance.compressPublicKey(publicKey!);
      print("${privateKeyHex} Private Key Hex");
      print("${HexUtils.decode(privateKeyHex)} Private Key Unit8List");
      print(publicKeyCompredHex);
      print("Address: ${_ecInstance.getAddressFromPublicKey(publicKey!)}");
    }
  }

  Future<String?> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(privateKeySharedRef);
  }

  Future _saveData(String password) async {
    final privateKeyPkcs8Pem =
        CryptoUtils.encodePrivateEcdsaKeyToPkcs8(privateKey!);
    final prefs = await SharedPreferences.getInstance();
    String encryptedPrivatePemData =
        EncryptData.encryptAES(privateKeyPkcs8Pem, password);
    await prefs.setString(privateKeySharedRef, encryptedPrivatePemData);
  }

  Future<bool> loadWallet(String password) async {
    try {
      print("----- Load Wallet ------");
      String? privateKeyData = await _getData();
      if (privateKeyData != null) {
        String descryptedPrivatePemData =
            EncryptData.decryptAES(privateKeyData, password);
        privateKey = CryptoUtils.ecPrivateKeyFromPem(descryptedPrivatePemData);
        publicKey = _ecInstance.derivePublicKey(privateKey!);
        consoleKeyInfo();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearWallet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(privateKeySharedRef);
    } catch (e) {
      return false;
    }
  }

  Future<bool> importWallet(String privateKeyHex, String password) async {
    try {
      print("----- Import Wallet ------");
      privateKey = ECPrivateKey(
        BigInt.parse(privateKeyHex, radix: 16),
        _ecInstance.secp256k1DomainParameter,
      );
      publicKey = _ecInstance.derivePublicKey(privateKey!);
      await _saveData(password);
      consoleKeyInfo();
      return true;
    } catch (e) {
      return false;
    }
  }
}
