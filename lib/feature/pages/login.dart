import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/code/route/app_route_name.dart';
import 'package:tuit_data_encryption/code/service/storage_service.dart';
import 'package:tuit_data_encryption/code/service/utils_service.dart';
import 'package:tuit_data_encryption/feature/widgets/custom_text_widget.dart';
import 'package:tuit_data_encryption/feature/widgets/main_button.dart';

import '../widgets/textfield_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();

  Future<bool> checkUser({required String name, required String pass}) async {
    String? nameLocale = await AppStorage.$read(key: StorageKey.userName);
    String? passLocale = await AppStorage.$read(key: StorageKey.password);
    log("Name locale = $nameLocale");
    log("Password locale $passLocale");
    if (nameLocale != null && passLocale != null && name == nameLocale && pass == passLocale) {
      log("Name locale = $nameLocale");
      log("Password locale $passLocale");
      await AppStorage.$write(key: StorageKey.isLogin, value: "true");
      Utils.fireSnackBar("Successfully Login User", context);
      return true;
    } else {
      Utils.fireSnackBar("Something went wring at Login", context);
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
      backgroundColor: const Color.fromRGBO(1, 27, 91, 1.0),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              SizedBox(height: 250, child: SvgPicture.asset("assets/svg/login.svg")),
              TextFieldWidget(controller: emailCtr, hintText: "UserName", borderColor: Colors.deepOrange),
              TextFieldWidget(controller: passCtr, hintText: "Password", keyboardType: TextInputType.number, borderColor: Colors.deepOrange),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => context.go("${AppRouteName.login}/${AppRouteName.refreshPassword}"),
                      child: const CustomTextWidget("Forgot Password?", fontWeight: FontWeight.w600, color: Colors.blueAccent))
                ],
              ),
              const SizedBox(height: 50),
              MainButton(
                onPressed: () async {
                  final value = await checkUser(name: emailCtr.text, pass: passCtr.text);
                  if (value) {
                    emailCtr.clear();
                    passCtr.clear();
                    context.go(AppRouteName.main);
                  }else{
                    log("login function is not working");
                  }
                },
                title: "Login",
                height: 55,
                textC: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.go("${AppRouteName.login}/${AppRouteName.register}"),
                    child: const CustomTextWidget("Don't have an Account?", fontWeight: FontWeight.w600, color: Colors.blueAccent),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
