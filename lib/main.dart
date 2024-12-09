import 'package:flutter/material.dart';
import 'package:tuit_data_encryption/code/route/app_route.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
void main()=> runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    func1();
    return MaterialApp.router(
      title: 'Encryption',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      routerConfig: AppRouter.router,
    );
  }
}

void func1 (){
  final plainText = "Hello, Flutter Encryption!";

  // Generate a key and IV (Initialization Vector)
  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  final iv = encrypt.IV.fromLength(16); // 16 bytes IV

  // Create the encrypter
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // Encrypt
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print("Encrypted Text: ${encrypted.base64}");

  // Decrypt
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print("Decrypted Text: $decrypted");
}



