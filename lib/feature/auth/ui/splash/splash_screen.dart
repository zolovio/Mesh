import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh/configs/api_end_point.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/widgets/background_gradient.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initFunc() async {
    const storage = FlutterSecureStorage();
    Timer(const Duration(seconds: 2), () async {
      var authData = await storage.read(key: 'authTokenData');
      var firstTimeLogin = await storage.read(key: 'firstTimeLogin');
      if (authData != null) {
        APIEndpoints.authTokenData = AuthTokenModel.deserialize(authData);
        if (firstTimeLogin != null && firstTimeLogin == 'true') {
          Navigator.pushReplacementNamed(context, AppRouter.skillScreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
        }
      } else {
        Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
      }
    });
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
