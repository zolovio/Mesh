import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/home_screens/models/file_model.dart';
import 'package:mesh/feature/home_screens/models/portfolio_images_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var isUploading = false.obs;

  var portfolioFilesList = <FileModel>[].obs;
  var portfolioImagesList = <PortfolioImage>[].obs;
  Rx<String> imagePath = "".obs;

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    fetchPortfolioImages();
    super.onInit();
  }

  Future uploadMedia({
    required String filepath,
    required String postbody,
    required List<String> posttags,
    // required List<Map<String, String>> filesids,
    required String posttype,
  }) async {
    try {
      isUploading(true);

      var data = await RemoteHomeServices.UploadFile(filepath);
      // print('all posts: ${data['data']}');
      if (data != null) {
        portfolioFilesList.add(FileModel.fromJson(data["data"]));
        portfolioImagesList.add(
          PortfolioImage(
            id: portfolioFilesList[0].id,
            userCreated: portfolioFilesList[0].uploadedBy,
            dateCreated: portfolioFilesList[0].uploadedOn.toString(),
            image: portfolioFilesList[0].filenameDownload,
          ),
        );
        await uploadProfileImages(fileId: portfolioFilesList[0].id.toString());
        return portfolioFilesList[0].id;
      }
      if (kDebugMode) {
        print(portfolioFilesList);
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.');
      isUploading(false);
      return null;
    }
  }

  Future uploadProfileImages({
    required fileId,
  }) async {
    try {
      var data = await RemoteHomeServices.uploadProfileImages(fileId);
      if (data != null) {
        try {
          // filesList.add(FileModel.fromJson(data));
          isUploading(false);
          FlutterToast.show(message: 'Post Uploaded');
        } catch (e) {
          isUploading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
        print(portfolioFilesList);
        update();
      }
      return data;
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.$e');

      isUploading(false);
    }
  }

  Future fetchPortfolioImages() async {
    try {
      PortfolioImageModel portfolioImages = await RemoteHomeServices.fetchUserPortfolioImages();
      print(portfolioImages.data);

      if (portfolioImages.data != null && portfolioImages.data!.isNotEmpty) {
        for (var image in portfolioImages.data!) {
          portfolioImagesList.add(image);
        }

        if (kDebugMode) {
          print(portfolioImages.data!.length);
        }
        update();
      }

      // if (likePost.like!.id != null) {
      //   return true;
      // } else {
      //   return false;
      // }
    } finally {
      update();
    }
  }
}
