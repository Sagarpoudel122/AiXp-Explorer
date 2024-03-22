import 'dart:io';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/ec_signature_verify.dart';
import 'package:e2_explorer/dart_e2/ec_signature_verify/enctyption_aes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/export.dart';

class AixpWallet {
  final BuildContext context;
  AixpWallet(this.context);
  static const privateKeyPath = '/private.txt';
  final ecHeaderPrefixForDer = "3056301006072a8648ce3d020106052b8104000a034200";
  final _ecInstance = EcSignatureAndVerifier();
  final passsword = '12345678';

  ECPrivateKey? privateKey;
  ECPublicKey? publicKey;

  Future<String> getPrivateKeyPath() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    String dirPath = '${appDocumentsDir.path}$privateKeyPath';
    return dirPath;
  }

  createWallet() async {
    try {
      print("----- Create Wallet------");
      var keyPair = _ecInstance.generateSecp256k1KeyPair();
      privateKey = keyPair.privateKey as ECPrivateKey;
      publicKey = keyPair.publicKey as ECPublicKey;

      final privateKeyPkcs8Pem =
          CryptoUtils.encodePrivateEcdsaKeyToPkcs8(privateKey!);

      String dirPath = await getPrivateKeyPath();

      String encryptedPrivatePemData =
          EncryptData.encryptAES(privateKeyPkcs8Pem, passsword);
      final file = File(dirPath);
      if (!file.existsSync()) {
        await file.create();
      }
      await file.writeAsString(encryptedPrivatePemData);
    } catch (e) {
      rethrow;
    }
  }

  initializeWallet() async {
    print("----Initializing Wallet----- \n\n");
    String dirPath = await getPrivateKeyPath();
    final file = File(dirPath);
    if (file.existsSync()) {
      loadWallet();
    } else {
      createWallet();
    }
  }

  consoleKeyInfo() {
    final publicKeyCompredHex = _ecInstance.compressPublicKey(publicKey!);

    print(_ecInstance.compressPublicKey(publicKey!));
    print(ecHeaderPrefixForDer);
    print("Address: ${_ecInstance.getAddressFromPublicKey(publicKey!)}");
  }

  Future<void> loadWallet() async {
    try {
      print("----- Load Wallet ------");
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      String dirPath = '${appDocumentsDir.path}$privateKeyPath';
      final file = File(dirPath);
      String encryptedPemData = await file.readAsString();
      String descryptedPrivatePemData =
          EncryptData.decryptAES(encryptedPemData, passsword);
      privateKey = CryptoUtils.ecPrivateKeyFromPem(descryptedPrivatePemData);
      publicKey = _ecInstance.derivePublicKey(privateKey!);
      consoleKeyInfo();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> importWallet() async {
    // Todo: Depending upon how private key is exported we need a mechanism for import wallet
    await Future.delayed(Duration.zero);
  }
}
