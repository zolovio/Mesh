import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/configs/route.dart';
import 'package:mesh/configs/theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mesh Network',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: getPages,
    );
  }
}
