import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/code/service/storage_service.dart';
import 'package:tuit_data_encryption/feature/widgets/custom_fade_animation.dart';
import 'package:flutter_svg/svg.dart';
import '../../code/route/app_route_name.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;

  Future<void> init() async {
    String? result = await AppStorage.$read(key: StorageKey.isLogin);
    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted && result != null && result == "true") {
       context.go(AppRouteName.main);
      }else{
        context.go(AppRouteName.login);
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 27, 91, 1.0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomFadeAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 300, child: SvgPicture.asset("assets/svg/Security-bro.svg")),
                const SizedBox(height: 15),
                const Text(
                  "Welcome to Data Encryption Application",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


