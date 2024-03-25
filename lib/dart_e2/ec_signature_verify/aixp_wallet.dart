import 'dart:io';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/ec_signature_verify.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/enctyption_aes.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/export.dart';
import 'package:convert/convert.dart';

class AixpWallet {
  AixpWallet();
  static const privateKeyPath = '/private.txt';
  final ecHeaderPrefixForDer = "3056301006072a8648ce3d020106052b8104000a034200";
  final _ecInstance = EcSignatureAndVerifier();

  ECPrivateKey? privateKey;
  ECPublicKey? publicKey;

  String get privateKeyHex {
    return privateKey!.d!.toRadixString(16).padLeft(64, '0');
  }

  String get publicKeyHexCompressed =>
      _ecInstance.compressPublicKey(publicKey!);

  String get walletAddress => _ecInstance.getAddressFromPublicKey(publicKey!);

  String get addressToShow {
    if (walletAddress.length < 3) {
      return '...';
    }
    if (walletAddress.length < 15) {
      walletAddress.replaceRange((walletAddress.length / 2).round() - 1,
          (walletAddress.length / 2).round(), '..');
    }
    return walletAddress.replaceRange(9, walletAddress.length - 5, '...');
  }

  Future<String> getPrivateKeyPath() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    String dirPath = '${appDocumentsDir.path}$privateKeyPath';
    return dirPath;
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
    String dirPath = await getPrivateKeyPath();
    final file = File(dirPath);
    if (file.existsSync()) {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteNames.walletPassword);
    } else {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteNames.walletPage);
    }
  }

  testPrivateKey() {
    // var keyPair = _ecInstance.generateSecp256k1KeyPair();
    // privateKey = keyPair.privateKey as ECPrivateKey;
    // publicKey = keyPair.publicKey as ECPublicKey;
    // consoleKeyInfo();
    // privateKey = ECPrivateKey(
    //   BigInt.parse(privateKeyHex, radix: 16),
    //   _ecInstance.secp256k1DomainParameter,
    // );
    // publicKey = _ecInstance.derivePublicKey(privateKey!);
    // consoleKeyInfo();
  }

  consoleKeyInfo() {
    final publicKeyCompredHex = _ecInstance.compressPublicKey(publicKey!);
    print(privateKeyHex);
    print(_ecInstance.compressPublicKey(publicKey!));

    print("Address: ${_ecInstance.getAddressFromPublicKey(publicKey!)}");
  }

  Future _saveData(String password) async {
    final privateKeyPkcs8Pem =
        CryptoUtils.encodePrivateEcdsaKeyToPkcs8(privateKey!);

    String dirPath = await getPrivateKeyPath();

    String encryptedPrivatePemData =
        EncryptData.encryptAES(privateKeyPkcs8Pem, password);
    final file = File(dirPath);
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsString(encryptedPrivatePemData);
  }

  Future<void> loadWallet(String password) async {
    try {
      print("----- Load Wallet ------");
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      String dirPath = '${appDocumentsDir.path}$privateKeyPath';
      final file = File(dirPath);
      String encryptedPemData = await file.readAsString();
      String descryptedPrivatePemData =
          EncryptData.decryptAES(encryptedPemData, password);
      privateKey = CryptoUtils.ecPrivateKeyFromPem(descryptedPrivatePemData);
      publicKey = _ecInstance.derivePublicKey(privateKey!);
      consoleKeyInfo();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> importWallet(String privateKeyHex, String password) async {
    try {
      print("----- Import Wallet ------");
      privateKey = ECPrivateKey(
        BigInt.parse(privateKeyHex, radix: 16),
        _ecInstance.secp256k1DomainParameter,
      );
      publicKey = _ecInstance.derivePublicKey(privateKey!);
      await _saveData(password);
      consoleKeyInfo();
    } catch (e) {
      rethrow;
    }
  }
}
