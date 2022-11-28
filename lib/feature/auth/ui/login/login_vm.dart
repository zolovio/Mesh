import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mesh/common/waiting_screen.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/auth/domain/model/veryfy_model.dart';
import 'package:mesh/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:mesh/main.dart';

final AutoDisposeChangeNotifierProvider<LoginVm> loginVmProvider =
    ChangeNotifierProvider.autoDispose<LoginVm>((ref) {
  return LoginVm();
});

class LoginVm extends ChangeNotifier {
  late AuthUseCase _useCase;
  LoginVm() {
    _useCase = AuthUseCase();
  }
  void onRequestOtp(String mobile, BuildContext context) async {
    navigatorKey.currentState?.pushNamed(AppRouter.verifyScreen,
        arguments: VerifyModel(mobileNumber: mobile));
  }

  Future<void> onGoogleSignInTap(BuildContext context) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          // WaitingScreen.show(context);
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          User? user = userCredential.user;
          final userDataResult = await _useCase.getUser(username: user!.email!);
          userDataResult?.when(success: (success) async {
            if (success!.isNotEmpty) {
              final result = await _useCase.login(
                user.email,
                user.uid,
              );
              result?.when(success: (success) async {
                final storage = FlutterSecureStorage();
                var firstTimeLogin = await storage.read(key: 'firstTimeLogin');
                WaitingScreen.hide(context);
                if (firstTimeLogin != null && firstTimeLogin == 'first') {
                  navigatorKey.currentState?.pushNamed(AppRouter.skillScreen);
                } else {
                  navigatorKey.currentState?.pushNamed(AppRouter.homeScreen);
                }
              }, failure: (failure) {
                // WaitingScreen.hide(context);
                FlutterToast.show(message: failure!, color: Colors.red);
              });
            } else {
              final result = await _useCase.signUp(
                password: user.uid,
                username: user.email!,
                firstName: user.displayName,
              );
              result?.when(success: (success) async {
                final loginResult = await _useCase.login(user.email, user.uid);
                loginResult?.when(success: (success) {
                  // WaitingScreen.hide(context);
                  FlutterToast.show(message: 'GoogleSign In Successfully');
                  navigatorKey.currentState?.pushNamed(AppRouter.skillScreen);
                }, failure: (failure) {
                  // WaitingScreen.hide(context);
                  FlutterToast.show(message: failure!, color: Colors.red);
                });
              }, failure: (failure) {
                // WaitingScreen.hide(context);
                FlutterToast.show(message: failure!, color: Colors.red);
              });
            }
          }, failure: (failure) {
            // WaitingScreen.hide(context);
          });
        } on FirebaseAuthException catch (e) {
          // WaitingScreen.hide(context);
          if (e.code == 'account-exists-with-different-credential') {
            FlutterToast.show(
                message: 'Account already exists with different credential.',
                color: Colors.red);
          } else if (e.code == 'invalid-credential') {
            FlutterToast.show(message: 'Invalid Credential', color: Colors.red);
          }
        } catch (e) {
          // WaitingScreen.hide(context);
          FlutterToast.show(
              message: 'Something went wrong, please try again',
              color: Colors.red);
        }
      }
    } else {
      final result = await _useCase.login(currentUser.email, currentUser.uid);
      result?.when(success: (success) {
        // WaitingScreen.hide(context);
        FlutterToast.show(message: 'GoogleSign In Successfully');
        navigatorKey.currentState?.pushNamed(AppRouter.skillScreen);
      }, failure: (failure) {
        // WaitingScreen.hide(context);
        FlutterToast.show(message: failure!, color: Colors.red);
      });
    }
  }
}
