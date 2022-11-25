import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesh/feature/auth/domain/model/veryfy_model.dart';
import 'package:mesh/feature/auth/ui/verify/verify_vm.dart';
import 'package:mesh/widgets/background_gradient.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/label.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  final VerifyModel verifyModel;
  const VerifyScreen({Key? key, required this.verifyModel}) : super(key: key);

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final otpController = TextEditingController();
  var done = false;
  var error = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int? resendToken;
  final List<String> errorText = [
    "OTP has expired. Please request for a new one "
  ];

  bool isActive = false;

  @override
  void initState() {
    ref.read(verifyVmProvider).resendOtp(widget.verifyModel);
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Consumer(builder: (context, ref, _) {
        final _vm = ref.watch(verifyVmProvider);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              const BackgroundGradient(),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UnderLinedText(text: "Verify"),
                          const SizedBox(width: 5),
                          Text("OTP",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge),
                        ],
                      ),
                      SizedBox(
                        height: 5 + screenHeight * 0.02,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                    "assets/images/verify-image.png",
                                    width: double.infinity,
                                    height: 189,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 32),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Color(0xffA3A2A8),
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text:
                                          "You’re almost there! we sent you an OTP on your mobile number to  ",
                                    ),
                                    TextSpan(
                                        text:
                                            "+92 ${widget.verifyModel.mobileNumber}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 32,
                                ),
                                height: 61,
                                width: screenWidth * 0.7,
                                child: PinCodeTextField(
                                  // key: form,
                                  controller: otpController,
                                  autoFocus: true,
                                  appContext: context,
                                  validator: (v) {
                                    // if (v == "1234") {
                                    //   return "OTP has expired. Please request for a new one ";
                                    // }
                                  },
                                  // errorTextSpace: 20,
                                  // errorTextMargin: const EdgeInsets.only(top: 60),
                                  pastedTextStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32,
                                      color: (error != 0)
                                          ? const Color(0xffEB5757)
                                          : Theme.of(context).focusColor),
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32,
                                      color: (error != 0)
                                          ? const Color(0xffEB5757)
                                          : Theme.of(context).focusColor),
                                  length: 6,
                                  animationType: AnimationType.none,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderWidth: 1,
                                    borderRadius: BorderRadius.circular(8),
                                    fieldHeight: 61,
                                    fieldWidth: 44,
                                    errorBorderColor: const Color(0xffEB5757),
                                    activeFillColor: Colors.transparent,
                                    activeColor: (error != 0)
                                        ? const Color(0xffEB5757)
                                        : const Color(0xffFAAF56),
                                    selectedColor: const Color(0xffFAAF56),
                                    inactiveColor: const Color(0xffFAAF56),
                                    selectedFillColor: Colors.transparent,
                                    inactiveFillColor: Colors.transparent,
                                  ),
                                  cursorColor: Theme.of(context).focusColor,
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {},

                                  onChanged: (value) {
                                    if (value.length == 6) {
                                      setState(() {
                                        done = true;
                                      });
                                    } else {
                                      if (done) {
                                        setState(() {
                                          done = false;
                                        });
                                      }
                                    }
                                  },
                                  beforeTextPaste: (text) {
                                    return true;
                                  },
                                ),
                              ),
                              (error != 0)
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 14),
                                      child: Text(errorText[error - 1],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffFE6363))))
                                  : const SizedBox(height: 40),
                              CustomButton(
                                  margin: const EdgeInsets.all(0),
                                  textSize: 16,
                                  height: 59,
                                  fontWeight: FontWeight.w600,
                                  borderRadius: 8,
                                  primaryColor: (done)
                                      ? Theme.of(context).focusColor
                                      : const Color(0xffBDBDBD),
                                  buttonText: "Verify OTP",
                                  onPressed: (done)
                                      ? () {
                                          _vm.mobileVerification(
                                              widget.verifyModel,
                                              otpController.text.trim(),
                                              context);
                                          // Get.toNamed("/verify");
                                          // Get.toNamed("/home");
                                          // Get.toNamed("/error");
                                        }
                                      : null),
                              const SizedBox(height: 24),
                              isActive
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Resend OTP in ${_start}s",
                                          style: TextStyle(
                                              color: const Color(0xff797979)
                                                  .withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Didn't receive code? ",
                                          style: TextStyle(
                                              color: const Color(0xff797979)
                                                  .withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        InkWell(
                                          onTap: () {
                                            _vm.resendOtp(widget.verifyModel);
                                            startTimer();
                                          },
                                          child: Text(
                                            "Resend",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back_ios_outlined,
                        color: Color(0xff2341D5)),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  late Timer _timer;
  late int _start = 20;
  void startTimer() {
    _start = 20;
    setState(() {
      isActive = true;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          isActive = false;
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
