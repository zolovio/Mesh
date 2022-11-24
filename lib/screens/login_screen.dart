import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mesh/screens/home_screens/home_tab/user_tab.dart';
import 'package:mesh/screens/more_apply_details_screen.dart';
import 'package:mesh/widgets/background_gradient.dart';
import 'package:mesh/widgets/button.dart';

import 'package:mesh/widgets/label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobile = TextEditingController();
  var value = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            const BackgroundGradient(),
            Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const UnderLinedText(text: "Log In"),
                        const SizedBox(width: 5),
                        Text("Account",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.85,
                        child: Text("Hello, Welcome to Mesh",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium)),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset("assets/images/login-image.png",
                                width: double.infinity,
                                height: 189,
                                fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 26),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const HeadingText(
                              text: "Mobile Number",
                            ),
                          ),
                          const SizedBox(height: 11),
                          CustomTextField(
                            controller: mobile,
                            hintText: "Add mobile number",
                            multiline: false,
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            borderColor: const Color(0xffFAAF56),
                          ),
                          const SizedBox(height: 0),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: const Color(0xffF3F3F3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Checkbox(
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: value,
                                  onChanged: (value) {
                                    setState(() {
                                      this.value = value as bool;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text("Keep me Signed In",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff9D9BA3)))
                            ],
                          ),
                          const SizedBox(height: 27),
                          CustomButton(
                              margin: const EdgeInsets.all(0),
                              textSize: 16,
                              height: 59,
                              fontWeight: FontWeight.w600,
                              borderRadius: 8,
                              primaryColor: Theme.of(context).focusColor,
                              buttonText: "Request OTP",
                              onPressed: () {
                                Get.toNamed("/verify");
                                // Get.toNamed("/home");
                                // Get.toNamed("/error");
                              }),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 74.32, child: Divider()),
                              const SizedBox(width: 15),
                              Text("Or",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color(0xff060220)
                                          .withOpacity(0.5))),
                              const SizedBox(width: 15),
                              const SizedBox(width: 74.32, child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                      "assets/icons/facebook.svg",
                                      width: 33,
                                      height: 33,
                                      color: const Color(0xff076FE5),
                                      fit: BoxFit.fill),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                      "assets/icons/google.svg",
                                      width: 33,
                                      height: 33,
                                      fit: BoxFit.fill),
                                )
                              ]),
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Don’t have an account?",
                                      style: TextStyle(
                                          color: const Color(0xff797979)
                                              .withOpacity(0.5),
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Register here",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                )),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
