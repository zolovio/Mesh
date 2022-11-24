import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mesh/feature/auth/ui/login/login_vm.dart';
import 'package:mesh/feature/home_screens/home_tab/user_tab.dart';
import 'package:mesh/widgets/background_gradient.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/label.dart';

import '../../../../screens/more_apply_details_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final mobile = TextEditingController();
  var value = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer(builder: (context, ref, child) {
          final _vm = ref.watch(loginVmProvider);
          return Stack(children: [
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
                            // keyboardType: TextInputType.number,
                            // prefixText: Text("+91"),
                            multiline: false,
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            borderColor: const Color(0xffFAAF56),
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
                                FocusScope.of(context).unfocus();
                                // navigatorKey.currentState
                                //     ?.pushNamed(AppRouter.skillScreen);
                                _vm.onRequestOtp(mobile.text.trim(), context);
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
                                  onTap: () {
                                    _vm.onGoogleSignInTap(context);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/google.svg",
                                      width: 33,
                                      height: 33,
                                      fit: BoxFit.fill),
                                )
                              ]),
                          // Expanded(
                          //   child: Align(
                          //       alignment: Alignment.bottomCenter,
                          //       child: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Text(
                          //             "Don’t have an account?",
                          //             style: TextStyle(
                          //                 color: const Color(0xff797979)
                          //                     .withOpacity(0.5),
                          //                 fontSize: 12),
                          //           ),
                          //           const SizedBox(width: 4),
                          //           Text(
                          //             "Register here",
                          //             style: TextStyle(
                          //                 color: Theme.of(context).focusColor,
                          //                 fontSize: 12),
                          //           ),
                          //         ],
                          //       )),
                          // )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
