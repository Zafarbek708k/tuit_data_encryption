import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static final encrypt.Key key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  static final encrypt.IV iv = encrypt.IV.fromLength(16); // 16 bytes

  // Encryption method
  static String encryption({required String text}) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    String encryptionText = encrypted.base64; // Store Base64 string
    print("Encrypted Text: $encryptionText");
    return encryptionText;
  }
  static String decryption({required String text}) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(text, iv: iv);
    String decryptionText = decrypted; // Store decrypted text
    print("Decrypted Text: $decryptionText");
    return decryptionText;
  }
}

// class EncryptionService {
//   // AES Key and IV
//   static final encrypt.Key aesKey = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars for AES-256
//   static final encrypt.IV aesIv = encrypt.IV.fromLength(16); // 16 bytes
//
//   // DES Key and IV
//   static final encrypt.Key desKey = encrypt.Key.fromUtf8('8bytekey'); // 8 chars for DES
//   static final encrypt.IV desIv = encrypt.IV.fromLength(8); // 8 bytes
//
//   // RSA Key Pair (Public & Private keys)
//   static final rsaKeyPair = encrypt.RSAKeyParser().parse(
//     '''-----BEGIN RSA PRIVATE KEY-----
//     YOUR_RSA_PRIVATE_KEY_HERE
//     -----END RSA PRIVATE KEY-----''',
//   );
//
//   static final rsaPublicKey = encrypt.RSAKeyParser().parse(
//     '''-----BEGIN PUBLIC KEY-----
//     YOUR_RSA_PUBLIC_KEY_HERE
//     -----END PUBLIC KEY-----''',
//   );
//
//   // AES Encryption
//   static String aesEncryption(String text) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(aesKey));
//     final encrypted = encrypter.encrypt(text, iv: aesIv);
//     return encrypted.base64;
//   }
//
//   static String aesDecryption(String encryptedText) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(aesKey));
//     final decrypted = encrypter.decrypt64(encryptedText, iv: aesIv);
//     return decrypted;
//   }
//
//
//
//
//   // RSA Encryption
//   static String rsaEncryption(String text) {
//     final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: rsaPublicKey, privateKey: rsaKeyPair));
//     final encrypted = encrypter.encrypt(text);
//     return encrypted.base64;
//   }
//
//   static String rsaDecryption(String encryptedText) {
//     final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: rsaPublicKey, privateKey: rsaKeyPair));
//     final decrypted = encrypter.decrypt64(encryptedText);
//     return decrypted;
//   }
// }

