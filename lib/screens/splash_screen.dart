import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mesh/widgets/background_gradient.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initFunc() async {
    // bool? isLoggedIn = await AuthSharedPref.getUserLoggedInSharedPreference();
    // print("->${isLoggedIn.toString()}");
    // if (isLoggedIn == false || isLoggedIn == null) {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed("/login");
    });
    // } else {
    //   Get.offAllNamed("/home");
    // }
  }

  @override
  void initState() {
    initFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).focusColor,
        body: Stack(
          children: [
            const BackgroundGradient(
              white: true,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/logo.svg"),
                  const SizedBox(height: 17.2),
                  const Text(
                    "MESH NETWORK",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
