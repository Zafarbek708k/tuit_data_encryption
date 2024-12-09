import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/code/service/storage_service.dart';
import 'package:tuit_data_encryption/code/service/utils_service.dart';
import 'package:tuit_data_encryption/feature/widgets/main_button.dart';
import 'package:tuit_data_encryption/feature/widgets/textfield_widget.dart';
import '../../code/route/app_route_name.dart';

class RefreshPassword extends StatefulWidget {
  const RefreshPassword({super.key});

  @override
  State<RefreshPassword> createState() => _RefreshPasswordState();
}

class _RefreshPasswordState extends State<RefreshPassword> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  TextEditingController confirmPassCtr = TextEditingController();

  Future<bool>refreshPass({required String name, required String pass, required String confirmPass})async{
    String? name = await AppStorage.$read(key: StorageKey.userName);
    if(name != null && pass == confirmPass){
      await AppStorage.$write(key: StorageKey.password, value: pass);
      Utils.fireSnackBar("Successfully Refresh password", context);
      return true;
    }else{
      Utils.fireSnackBar("Something went wring at Refresh Password", context);
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
              SizedBox(height: 250, child: SvgPicture.asset("assets/svg/reset-password.svg")),
              TextFieldWidget(controller: emailCtr, hintText: "UserName", borderColor: Colors.green),
              TextFieldWidget(controller: passCtr, hintText: "Password", keyboardType: TextInputType.number, borderColor: Colors.green),
              TextFieldWidget(
                controller: confirmPassCtr,
                hintText: "Confirm Password",
                keyboardType: TextInputType.number,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 50),
              MainButton(onPressed: ()async{
                final value = await refreshPass(name: emailCtr.text, pass: passCtr.text, confirmPass: confirmPassCtr.text);
                if(value){
                  context.go(AppRouteName.login);
                }else{
                  log("refresh function is not working");
                }
              }, title: "Reset Password", height: 55, textC: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
