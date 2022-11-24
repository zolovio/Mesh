import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mesh/widgets/button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffE55757).withOpacity(0.3),
                  // const Color(0xffffffff).withOpacity(0),
                  const Color(0xffffffff).withOpacity(0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircleAvatar(
                    radius: 98.5,
                    backgroundColor: const Color(0xffDF2D2D).withOpacity(0.05),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffDF2D2D).withOpacity(0.1),
                      radius: 78.5,
                      child: CircleAvatar(
                        backgroundColor:
                            const Color(0xffDF2D2D).withOpacity(0.4),
                        radius: 60.165,
                        child: CircleAvatar(
                            backgroundColor: const Color(0xffDF2D2D),
                            radius: 44.5,
                            child: Stack(children: [
                              SvgPicture.asset("assets/icons/wifi.svg"),
                              Positioned(
                                  bottom: 3,
                                  right: 3,
                                  child: Container(
                                    width: 19.58,
                                    height: 19.58,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffDF2D2D)),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 18),
                                  ))
                            ])),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Oops! Not connected to the internet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff200202)),
                      )),
                  const SizedBox(height: 12),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Please try again!! :(",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff9A9A9C)),
                      )),
                  const SizedBox(height: 40),
                  CustomButton(
                      margin: const EdgeInsets.all(0),
                      textSize: 20,
                      width: 224,
                      height: 59,
                      fontWeight: FontWeight.w600,
                      borderRadius: 8,
                      primaryColor: Theme.of(context).focusColor,
                      buttonText: "Refresh",
                      onPressed: () {
                        Get.toNamed("/home");
                        // Get.toNamed("/error");
                      }),
                ]),
              ),
            )));
  }
}
