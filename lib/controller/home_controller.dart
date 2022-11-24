import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mesh/screens/home_screens/home_tab/home_tab.dart';
import 'package:mesh/screens/home_screens/home_tab/notification_tab.dart';

import 'package:mesh/screens/user_info_screen.dart';

class HomeController extends GetxController {
  List<Widget> pages = <Widget>[
    const HomeTab(),
    Container(),
    NotificationTab(),
    const UserInfoScreen(
      myprofile: true,
    )
  ].obs;
  var selectedpage = 0.obs;
  var tags = false.obs;
  var business = false.obs;
}
