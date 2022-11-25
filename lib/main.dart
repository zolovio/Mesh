import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/configs/theme.dart';
import 'package:mesh/dependency/dependency_injection.dart';
import 'package:mesh/feature/auth/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC_RoHbDgMmwpRA5aab1ooT-Qf0W5KkgyQ",
      appId: "1:449637707302:android:4ee67b639c32bb050940e7",
      messagingSenderId: "Messaging sender id here",
      projectId: "meshapp-d2b57",
    ),
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupDependencies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mesh Network',
      theme: themeData,
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
