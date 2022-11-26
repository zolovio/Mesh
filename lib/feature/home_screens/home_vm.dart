import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesh/feature/home_screens/home_tab/home_tab.dart';
import 'package:mesh/feature/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/feature/userinfo/ui/user_info_screen.dart';

final homeVmProvider = ChangeNotifierProvider.autoDispose((ref) => HomeVm());

class HomeVm extends ChangeNotifier {
  List<Widget> pages = <Widget>[
    const HomeTab(),
    Container(),
    NotificationTab(),
    const UserInfoScreen(
      myprofile: true,
    )
  ];
  var selectedPage = 0;
  var tags = false;
  var business = false;

  void onSelectedPage(int i) {
    selectedPage = i;
    notifyListeners();
  }
}
