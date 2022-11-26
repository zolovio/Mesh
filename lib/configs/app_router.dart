import 'package:flutter/material.dart';
import 'package:mesh/feature/auth/domain/model/veryfy_model.dart';
import 'package:mesh/feature/auth/ui/login/login_screen.dart';
import 'package:mesh/feature/auth/ui/splash/splash_screen.dart';
import 'package:mesh/feature/auth/ui/verify/verify_screen.dart';
import 'package:mesh/feature/home_screens/home_screen.dart';
import 'package:mesh/feature/skills/ui/prepare_screen.dart';
import 'package:mesh/feature/skills/ui/select_skill_screen.dart';

import '../screens/upload_screen.dart';

class AppRouter {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signUp';
  static const String errorScreen = '/error';
  static const String skillScreen = '/skillScreen';
  static const String verifyScreen = '/verifyScreen';
  static const String prepareScreen = '/prepareScreen';
  static const String homeScreen = '/homeScreen';
  static const String uploadScreen = '/uploadScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case prepareScreen:
        return MaterialPageRoute(builder: (_) => const PrepareScreen());
      case skillScreen:
        return MaterialPageRoute(builder: (_) => const SelectSkillScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case uploadScreen:
        return MaterialPageRoute(builder: (_) => const UploadScreen());
      case verifyScreen:
        return MaterialPageRoute(
            builder: (_) => VerifyScreen(
                  verifyModel: settings.arguments as VerifyModel,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => RouteErrorScreen(
                  title: 'Route Not Found',
                  message: 'Error! The route ${settings.name} not found.',
                ));
    }
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
