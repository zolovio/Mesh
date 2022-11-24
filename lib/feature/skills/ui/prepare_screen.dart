import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/main.dart';

import 'package:percent_indicator/percent_indicator.dart';

import '../../../widgets/background_gradient.dart';

class PrepareScreen extends StatefulWidget {
  const PrepareScreen({Key? key}) : super(key: key);

  @override
  State<PrepareScreen> createState() => _PrepareScreenState();
}

class _PrepareScreenState extends State<PrepareScreen> {
  initFunc() async {
    // bool? isLoggedIn = await AuthSharedPref.getUserLoggedInSharedPreference();
    // print("->${isLoggedIn.toString()}");
    // if (isLoggedIn == false || isLoggedIn == null) {
    Timer(const Duration(seconds: 2), () {
      /// Get.offAllNamed("/error");
      navigatorKey.currentState?.pushReplacementNamed(AppRouter.homeScreen);
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
        body: Stack(
      children: [
        const BackgroundGradient(),
        Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularPercentIndicator(
            radius: 60.16,
            lineWidth: 2.0,
            percent: 0.25,
            progressColor: Theme.of(context).focusColor,
            backgroundColor: Theme.of(context).focusColor.withOpacity(0.4),
            center: Container(
                width: 89.95,
                height: 89.95,
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    shape: BoxShape.circle),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 9.71,
                      height: 7.71,
                      margin: const EdgeInsets.only(right: 7.04),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F2F4).withOpacity(0.5),
                          shape: BoxShape.circle),
                    ),
                    Container(
                      width: 9.71,
                      height: 7.71,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                    Container(
                      width: 9.71,
                      height: 7.71,
                      margin: const EdgeInsets.only(left: 7.04),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F2F4).withOpacity(0.2),
                          shape: BoxShape.circle),
                    )
                  ],
                )),
          ),
          const SizedBox(height: 40),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "Preparing your Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff200202)),
              )),
          const SizedBox(height: 11),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 55),
              alignment: Alignment.center,
              child: const Text(
                "Setting up your screen may take some while. Just sit and relax!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xff9A9A9C)),
              )),
        ]))
      ],
    ));
  }
}
