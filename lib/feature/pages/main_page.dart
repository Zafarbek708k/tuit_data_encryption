import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/code/route/app_route_name.dart';
import 'package:tuit_data_encryption/code/service/des_encryption_service.dart';
import 'package:tuit_data_encryption/code/service/encryption_service.dart';
import 'package:tuit_data_encryption/code/service/rsa_encryption_service.dart';
import 'package:tuit_data_encryption/code/service/storage_service.dart';
import 'package:tuit_data_encryption/code/service/utils_service.dart';
import 'package:tuit_data_encryption/feature/widgets/advanced_drawer/advanced_drawer.dart';
import 'package:tuit_data_encryption/feature/widgets/custom_text_widget.dart';
import 'package:tuit_data_encryption/feature/widgets/main_button.dart';
import 'package:tuit_data_encryption/feature/widgets/result_widget.dart';
import 'package:tuit_data_encryption/feature/widgets/tf_widget.dart';

import '../widgets/advanced_drawer/drawer_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController msgCtrl = TextEditingController();
  bool rsa = false, aes = false, des = false, isWork = true;
  String encryptionText = "", decryptionText = "", userName = '';

  String aesEncryption({required String text}) {
    String result = EncryptionService.encryption(text: text);
    encryptionText = result;
    setState(() {});
    return result;
  }

  void aesDecryption({required String text}) {
    String result = EncryptionService.decryption(text: text);
    decryptionText = result;
    setState(() {});
  }

  void rsaEncryption({required String text}){
   String resultEnc =  RsaEncryptionService.enc(text);
   setState(() {
     encryptionText = resultEnc;
   });
  }
  void rsaDecryption({required String text}){
   setState(() {
     decryptionText = text;
   });
  }

  void desEnc({required String text})async{
    String result = await DesEncryptionService.crypt(text);
    encryptionText = result;
    setState(() {});
  }

  void desDec({required String text}){
    setState(() {
      decryptionText = text;
    });
  }


  Future<void> findUserName() async {
    String? result = await AppStorage.$read(key: StorageKey.userName);
    if (result != null) {
      setState(() {
        userName = result;
      });
    }
  }

  @override
  void initState() {
    findUserName();
    super.initState();
  }



  @override
  void dispose() {
    msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: AdvancedDrawerController(),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      backdropColor: const Color.fromRGBO(1, 27, 91, 1.0),
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(1, 27, 91, 1.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: SizedBox(
                    width: double.infinity, child: CustomTextWidget("$userName.", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
              ),
              MainButton(
                title: "Deleted Account",
                textC: Colors.white,
                onPressed: () async {
                  await AppStorage.$delete(key: StorageKey.isLogin);
                  Utils.fireSnackBar("Successfully deleted account", context);
                  context.go(AppRouteName.login);
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextWidget("Created by ", color: Colors.white,fontWeight: FontWeight.w400),
                  CustomTextWidget("Zafarbek", color: Color.fromRGBO(37, 203, 37, 1.0),fontWeight: FontWeight.w600, fontSize: 26),
                ],
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(1, 27, 91, 1.0),
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: CustomTextWidget(userName, color: Colors.white, fontSize: 20),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
          child: ListView(
            children: [
              TfWidget(msgCtrl: msgCtrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                      title: "RSA",
                      width: 85,
                      height: 50,
                      textC: Colors.white,
                      borderC: rsa ? Colors.green : Colors.red,
                      onPressed: () {
                        setState(() {
                          rsa = true;
                          aes = false;
                          des = false;
                        });
                      }),
                  MainButton(
                      title: "AES",
                      width: 85,
                      height: 50,
                      textC: Colors.white,
                      borderC: aes ? Colors.green : Colors.red,
                      onPressed: () {
                        setState(() {
                          rsa = false;
                          aes = true;
                          des = false;
                        });
                      }),
                  MainButton(
                      title: "DES",
                      width: 60,
                      height: 50,
                      textC: Colors.white,
                      borderC: des ? Colors.green : Colors.red,
                      onPressed: () {
                        setState(() {
                          rsa = false;
                          aes = false;
                          des = true;
                        });
                      }),
                ],
              ),
              MainButton(
                  onPressed: () {
                    if (aes) {
                      aesEncryption(text: msgCtrl.text);
                      aesDecryption(text: aesEncryption(text: msgCtrl.text));
                    }
                    if (rsa && isWork && msgCtrl.text.isNotEmpty) {
                      isWork = false;
                      setState(() {});
                      rsaEncryption(text: msgCtrl.text);
                      rsaDecryption(text: msgCtrl.text);
                      log("rsa enc");
                    }
                    if(des && msgCtrl.text.isNotEmpty){
                      desDec(text: msgCtrl.text);
                      desEnc(text: msgCtrl.text);
                      log("Des");
                    }
                  },
                  title: "Encryption",
                  textC: Colors.white),
              const SizedBox(height: 20),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextWidget("Encrypted Text", color: Colors.white),
                  )),
              ResultWidget(result: encryptionText),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: EdgeInsets.all(8.0), child: CustomTextWidget("Decrypted Text", color: Colors.white)),
              ),
              ResultWidget(result: decryptionText),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.refresh_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isWork = true;
              msgCtrl.clear();
              encryptionText = "";
              decryptionText = "";
            });
          },
        ),
      ),
    );
  }
}
