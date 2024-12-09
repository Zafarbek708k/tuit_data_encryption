import 'package:fast_rsa/fast_rsa.dart' as fastRsa;
import 'package:fast_rsa/fast_rsa.dart';
import 'dart:math';
import 'package:pointycastle/src/platform_check/platform_check.dart';
import "package:pointycastle/export.dart";

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
    SecureRandom secureRandom,
    {int bitLength = 2048}) {
  // Create an RSA key generator and initialize it

  // final keyGen = KeyGenerator('RSA'); // Get using registry
  final keyGen = RSAKeyGenerator();

  keyGen.init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
      secureRandom));

  // Use the generator

  final pair = keyGen.generateKeyPair();

  // Cast the generated key pair into the RSA key types

   final myPublic = pair.publicKey as RSAPublicKey;
  final myPrivate = pair.privateKey as RSAPrivateKey;

  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
}

SecureRandom exampleSecureRandom() {

  final secureRandom = SecureRandom('Fortuna')
    ..seed(KeyParameter(
        Platform.instance.platformEntropySource().getBytes(32)));
  return secureRandom;
}



final pair = generateRSAkeyPair(exampleSecureRandom());
final public = pair.publicKey;
final private = pair.privateKey;


class RsaEncryptionService {
  // PKCS12KeyPair initialization
  final PKCS12KeyPair _pkcs12KeyPair = PKCS12KeyPair("", "", "");

  // RSA encryption using FastRsa
  Future<String> encryptRSA({required String payload}) async =>
      await fastRsa.RSA.encryptOAEP(payload, '', fastRsa.Hash.SHA256, "publicKey");

  // RSA decryption using FastRsa
  Future<String> decryptRSA({required String payload}) async =>
      await fastRsa.RSA.decryptOAEP(payload, '', fastRsa.Hash.SHA256, "privateKey");

  // Private function to generate random text similar to ciphertext
  static String _randomText(String txt) {
    const String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    final Random random = Random();
    final int length = txt.length <= 10
        ? 23
        : txt.length > 90
        ? (txt.length / 2).round()
        : txt.length * 2;

    return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
  }

  // Public function for encryption mock
  static String enc(String txt) {
    txt = _randomText(txt);
    return txt;
  }

  // Public function for decryption mock
  static String dec(String txt) {
    txt = _randomText(txt);
    return txt;
  }
}
