import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/api_repository/post_likes_api.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';

class PostLikeController extends GetxController {
  List<LikeCount>? likeCount = <LikeCount>[].obs;
  var like_count = "0".obs;
  var like_post = false.obs;
  var isLoading = false.obs;
  var postId = "".obs;
  var postLike = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // updateID(postID);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  updateID(String postID) {
    postId.value = postID;
    getLikesCount(postId.value);
    print('im print ${postId.value}');
  }

  getLikesCount(String postId) async {
    try {
      isLoading(true);

      LikeCount likeCount = await PostLikesApi.getLikesCount(postId);

      like_count.value = likeCount.count!;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> likeAPost(String postId) async {
    try {
      isLoading(true);

      LikePost likePost = await PostLikesApi.likeAPost(postId);

      print(likePost.toJson());
      print(likePost.like?.post);

      if (likePost.like!.id != null) {
        return true;
      } else {
        return false;
      }

      // like_count.value = likeCount.count!;
    } finally {
      isLoading(false);
    }
  }

  Future<List<Errors>?> unlikeAPost(String postId) async {
    try {
      isLoading(true);

      ErrorMessage unlikePost = await PostLikesApi.unlikeAPost(postId);

      // print(unlikePost.toJson());

      // postLike.value = false;

      return unlikePost.errors;
      // if (likePost.like!.id != null) {
      //   return true;
      // } else {
      //   return false;
      // }

      // like_count.value = likeCount.count!;
    } finally {
      isLoading(false);
    }
  }
}
