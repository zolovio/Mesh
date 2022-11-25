import 'package:get/get.dart';
import 'package:mesh/feature/auth/domain/model/post_like_model.dart';
import 'package:mesh/feature/home_screens/api_repository/post_likes_api.dart';

class PostLikeController extends GetxController {
  List<LikeCount>? likeCount = <LikeCount>[].obs;
  var count = "0".obs;

  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getLikesCount("aafaea28-0885-4a14-b797-a3a455aaa950");
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  getLikesCount(String postId) async {
    try {
      isLoading(true);

      LikeCount likeCount = await PostLikesApi.getLikesCount(postId);

      count.value = likeCount.count!;
    } finally {
      isLoading(false);
    }
  }
}
