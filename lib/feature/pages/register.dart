import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/code/service/storage_service.dart';
import 'package:tuit_data_encryption/code/service/utils_service.dart';
import 'package:tuit_data_encryption/feature/widgets/custom_text_widget.dart';
import 'package:tuit_data_encryption/feature/widgets/main_button.dart';
import 'package:tuit_data_encryption/feature/widgets/textfield_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();

  Future<bool> saveUser({required String name, required String pass}) async {
    if (name.length > 3 && pass.length >= 6) {
      await AppStorage.$write(key: StorageKey.userName, value: name);
      await AppStorage.$write(key: StorageKey.password, value: pass);
      Utils.fireSnackBar("Successfully Registered", context);
      return true;
    } else {
      Utils.fireSnackBar("Something went wrong", context);
      return false;
    }
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(1, 27, 91, 1.0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              SizedBox(height: 250, child: SvgPicture.asset("assets/svg/sign-up.svg")),
              TextFieldWidget(controller: emailCtr, hintText: "UserName", borderColor: Colors.green),
              TextFieldWidget(
                controller: passCtr,
                hintText: "Password Minimum 6 Character",
                keyboardType: TextInputType.number,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 50),
              MainButton(
                  onPressed: () async {
                    log("Email = ${emailCtr.text} pass = ${passCtr.text}");
                    bool result = await saveUser(name: emailCtr.text, pass: passCtr.text);
                    if (result) {
                      emailCtr.clear();
                      passCtr.clear();
                      context.pop();
                    } else {
                      log("Register function is not working ");
                    }
                  },
                  title: "Register",
                  height: 55,
                  textC: Colors.white),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const CustomTextWidget("Have an Account?", fontWeight: FontWeight.w600, color: Colors.blueAccent))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
