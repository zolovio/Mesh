import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/feature/home_screens/models/file_model.dart';
import 'package:mesh/feature/home_screens/models/post_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';

import 'package:mesh/screens/user_info_screen.dart';

import '../../../dependency/flutter_toast_dep.dart';
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
  var isupLoading = false.obs;
  var postsList = <PostModel>[].obs;
  var filesList = <FileModel>[].obs;
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    // fetchAllPosts();
    // RemoteHomeServices.refreshToken();
    super.onInit();
  }

  void fetchAllPosts() async {
    try {
      isLoading(true);
      var posts = await RemoteHomeServices.fetchposts();
      print('all posts: ${posts['data']}');
      if (posts != null) {
        for (var post in posts['data']) {
          postsList.add(PostModel.fromJson(post));
        }
        isLoading(false);

        if (kDebugMode) {
          print(postsList);
        }
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  Future UploadPostMedia({
    required String filepath,
    required String postbody,
    required List<String> posttags,
    // required List<Map<String, String>> filesids,
    required String posttype,
  }) async {
    try {
      isupLoading(true);
      var data = await RemoteHomeServices.UploadFile(filepath);
      print('all posts: ${data['data']}');
      if (data != null) {
        filesList.add(FileModel.fromJson(data));
        UploadPost(
            fileid: filesList[0].id.toString(),
            postbody: postbody,
            posttags: posttags,
            posttype: posttype);
        return filesList[0].id;
      }
      if (kDebugMode) {
        print(filesList);
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.');
      isupLoading(false);
      return null;
    }
  }

  void UploadPost({
    required fileid,
    required String postbody,
    required posttags,
    // required List<Map<String, String>> filesids,
    required String posttype,
  }) async {
    try {
      var data = await RemoteHomeServices.createpost(
          postbody: postbody,
          posttags: posttags,
          filesids: fileid == null
              ? null
              : [
                  {"directus_files_id": fileid.toString()}
                ],
          posttype: posttype);
      if (data != null) {
        try {
          // filesList.add(FileModel.fromJson(data));
          isupLoading(false);
          FlutterToast.show(message: 'Post Uploaded');
        } catch (e) {
          isupLoading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
        print(filesList);
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.$e');

      isupLoading(false);
    }
  }
}
