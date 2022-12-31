import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/home_screens/models/file_model.dart';
import 'package:mesh/feature/home_screens/models/portfolio_images_model.dart';
import 'package:mesh/feature/home_screens/models/portfolio_videos_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var isUploading = false.obs;

  var portfolioImagesList = <PortfolioImage>[].obs;
  var portfolioVideosList = <PortfolioVideo>[].obs;
  Rx<String> imagePath = "".obs;
  Rx<String> videoPath = "".obs;

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    fetchPortfolioImages();
    fetchPortfolioVideos();
    super.onInit();
  }

  Future uploadMedia({required String filepath, required String mediaType}) async {
    try {
      isUploading(true);

      var data = await RemoteHomeServices.UploadFile(filepath);

      if (data != null) {
        if (mediaType == "image") {
          FileModel fileModel = FileModel.fromJson(data["data"]);

          portfolioImagesList.add(
            PortfolioImage(
              id: fileModel.id,
              userCreated: fileModel.uploadedBy,
              dateCreated: fileModel.uploadedOn.toString(),
              image: fileModel.filenameDownload,
            ),
          );
          await uploadPortfolioImages(fileId: fileModel.id.toString());
        } else {
          FileModel fileModel = FileModel.fromJson(data["data"]);

          portfolioVideosList.add(
            PortfolioVideo(
              id: fileModel.id,
              userCreated: fileModel.uploadedBy,
              dateCreated: fileModel.uploadedOn.toString(),
              video: fileModel.filenameDownload,
            ),
          );
          await uploadPortfolioVideos(fileId: fileModel.id.toString());
        }
      }

      if (kDebugMode) {
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.');
      isUploading(false);
      return null;
    }
  }

  Future uploadPortfolioImages({required fileId}) async {
    try {
      var data = await RemoteHomeServices.uploadPortfolioImages(fileId);
      if (data != null) {
        try {
          isUploading(false);
          FlutterToast.show(message: 'Picture Uploaded');
        } catch (e) {
          isUploading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
        update();
      }
      return data;
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.$e');

      isUploading(false);
    }
  }

  Future uploadPortfolioVideos({required fileId}) async {
    try {
      var data = await RemoteHomeServices.uploadPortfolioVideos(fileId);
      if (data != null) {
        try {
          isUploading(false);
          FlutterToast.show(message: 'Video Uploaded');
        } catch (e) {
          isUploading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
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
    } finally {
      update();
    }
  }

  Future fetchPortfolioVideos() async {
    try {
      PortfolioVideosModel portfolioVideos = await RemoteHomeServices.fetchUserPortfolioVideos();
      print(portfolioVideos.data);

      if (portfolioVideos.data != null && portfolioVideos.data!.isNotEmpty) {
        for (var video in portfolioVideos.data!) {
          portfolioVideosList.add(video);
        }

        if (kDebugMode) {
          print(portfolioVideos.data!.length);
        }
        update();
      }
    } finally {
      update();
    }
  }
}
