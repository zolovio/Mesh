import 'package:flutter/material.dart';

class WaitingScreen {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Container(
              color: Colors.black12,
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            ),
          );
        });
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
