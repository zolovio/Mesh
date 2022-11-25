import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/feature/home_screens/models/post_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';

import 'package:mesh/screens/user_info_screen.dart';

import '../home_tab/home_tab.dart';

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

  var isLoading = true.obs;
  var postsList = <PostModel>[].obs;

  // @override
  // void onInit() {
  //   fetchAllPosts();
  //   super.onInit();
  // }

  void fetchAllPosts() async {
    try {
      isLoading(true);
      var posts = await RemoteHomeServices.fetchposts();
      print('all posts: ${posts['data']}');
      if (posts != null) {
        for (var post in posts['data']) {
          postsList.add(PostModel.fromJson(post));
        }
        if (kDebugMode) {
          print(postsList);
        }
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}
