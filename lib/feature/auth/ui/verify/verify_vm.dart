import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesh/common/waiting_screen.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/auth/domain/model/veryfy_model.dart';
import 'package:mesh/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:mesh/main.dart';

final verifyVmProvider = Provider.autoDispose(
  (ref) => VerifyVm(),
);

class VerifyVm extends ChangeNotifier {
  late AuthUseCase _useCase;
  VerifyVm() {
    _useCase = AuthUseCase();
  }

  bool isActive = false;

  late String verificationCode;

  mobileVerification(
      VerifyModel verifyModel, String smsCode, BuildContext context) async {
    print("Verification:::::::: $smsCode");
    print(verificationCode);
    WaitingScreen.show(context);
    try {
      log('Enter in Verification', name: 'Error Message');

      AuthCredential _authCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: smsCode);
      log(_authCredential.toString(), name: 'Error Message');
      await FirebaseAuth.instance
          .signInWithCredential(_authCredential)
          .then((UserCredential user) async {
        log(user.toString(), name: 'Phone Credential Token');
        if (user.user != null) {
          String mobileNumber = verifyModel.mobileNumber;
          final userDataResult =
              await _useCase.getUser(username: mobileNumber + '@mesh.com');
          userDataResult?.when(success: (success) async {
            if (success!.isNotEmpty) {
              final result = await _useCase.login(
                mobileNumber + '@mesh.com',
                mobileNumber,
              );
              result?.when(success: (success) async {
                final storage = FlutterSecureStorage();
                var firstTimeLogin = await storage.read(key: 'firstTimeLogin');
                WaitingScreen.hide(context);
                if (firstTimeLogin != null && firstTimeLogin == 'first') {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(AppRouter.skillScreen);
                } else {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(AppRouter.homeScreen);
                }
              }, failure: (failure) {
                WaitingScreen.hide(context);
                FlutterToast.show(message: failure!);
              });
            } else {
              await signUp(user.user!, verifyModel, context);
            }
          }, failure: (failure) {
            WaitingScreen.hide(context);
            FlutterToast.show(message: failure!);
          });
        } else {
          WaitingScreen.hide(context);
          FlutterToast.show(
              message: 'Invalid Verification Code', color: Colors.red);
        }
      });
    } on FirebaseAuthException catch (e) {
      WaitingScreen.hide(context);
      log(e.code, name: 'Error Message');
      FlutterToast.show(
          message: 'Invalid Verification Code', color: Colors.red);
    }
  }

  signUp(User user, verifyModel, context) async {
    String mobileNumber = verifyModel.mobileNumber;
    final result = await _useCase.signUp(
        username: mobileNumber + '@mesh.com',
        password: mobileNumber.toString());
    result?.when(success: (success) async {
      final loginResult = await _useCase.login(
          mobileNumber + '@mesh.com', mobileNumber.toString());
      loginResult?.when(success: (success) {
        WaitingScreen.hide(context);
        navigatorKey.currentState?.pushNamed(AppRouter.skillScreen);
      }, failure: (failure) {
        WaitingScreen.hide(context);
        FlutterToast.show(message: failure!);
      });
    }, failure: (failure) {
      WaitingScreen.hide(context);
      FlutterToast.show(message: failure!);
    });
  }

  resendOtp(VerifyModel verifyModel) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${verifyModel.mobileNumber}',
      verificationCompleted: (credential) {}, //PhoneAuthCredential
      verificationFailed: (FirebaseAuthException e) {
        log(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationCode = verificationId;
        notifyListeners();
        FlutterToast.show(message: 'OTP Sent Successfully');
        log(verificationId);
        log(resendToken.toString());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log(verificationId);
      },
    );
  }
}

class PhoneAuthCredential {}
