import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_des/flutter_des.dart';

class DesEncryptionService {
  static const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  static const _iv = "12345678";
  static Uint8List? _encrypt;
  static String? _decrypt = '';
  static String _encryptHex = '';
  static String? _decryptHex = '';

  static Future<String> crypt(String txt) async {
    if (txt.isEmpty) {
      txt = "Empty";
    }

    try {
      _encrypt = await FlutterDes.encrypt(txt, _key, iv: _iv);
      _decrypt = await FlutterDes.decrypt(_encrypt ?? Uint8List.fromList([]), _key, iv: _iv);
      _encryptHex = (await FlutterDes.encryptToHex(txt, _key, iv: _iv)) ?? "BvOHzUOcklgNpn1MaWvdn9DT4LyzS";
      _decryptHex = await FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv);
      if (_encryptHex != null) {
        return _encryptHex;
      } else {
        const String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        final Random random = Random();
        final int length = txt.length <= 10
            ? 23
            : txt.length > 90
                ? (txt.length / 2).round()
                : txt.length * 2;

        return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
      }
    } catch (e) {
      return "BvOHzUOcklgNpn1MaWvdn9DT4LyzS";
      print(e);
    }
  }
}
