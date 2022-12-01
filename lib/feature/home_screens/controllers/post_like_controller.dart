import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/api_repository/post_likes_api.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';
import 'package:mesh/feature/home_screens/models/post_liked_by_user.dart';

class PostLikeController extends GetxController {
  // final String userPostId;
  List<LikeCount>? likeCount = <LikeCount>[].obs;
  var like_count = "0".obs;
  var like_post = false.obs;
  var isLoading = false.obs;
  var postId = "".obs;
  var postLike = false.obs;
  var userLikedPostsList = [].obs;
  RxString textFieldValue = "".obs;

  // PostLikeController(this.userPostId);

  @override
  Future<void> onInit() async {
    // getLikesCount(userPostId);
    // postLikedByUser(userPostId);
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
    // postLikedByUser(postID);
  }

  Future<String?> getLikesCount(String postId) async {
    try {
      isLoading(true);

      LikeCount likeCount = await PostApi.getLikesCount(postId);

      like_count.value = likeCount.count!;
      return likeCount.count;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> likeAPost(String postId) async {
    try {
      isLoading(true);

      LikePost likePost = await PostApi.likeAPost(postId);

      if (likePost.like!.id != null) {
        postLike(true);
        return true;
      } else {
        postLike(false);
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

      ErrorMessage unlikePost = await PostApi.unlikeAPost(postId);

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

  // Future<List<UserLikePost>?> postLikedByUser(String postId) async {
  //   try {
  //     isLoading(true);
  //
  //     PostLikedByUser userLike = await PostApi.postLikedByUser(postId);
  //
  //     if (userLike.data?.first.id != null) {
  //       if (userLikedPostsList.isEmpty)
  //         userLikedPostsList.value = userLike.data!;
  //       postLike(true);
  //       return userLike.data;
  //     } else {
  //       postLike(false);
  //       return [];
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<List<Data>?> commentOnAPost(String comment, String postId) async {
    try {
      isLoading(true);

      PostLikedByUser commented = await PostApi.commentOnAPost(comment, postId);
      print(commented);

      // if (userLike.data?.first.id != null) {
      //   if (userLikedPostsList.isEmpty)
      //     userLikedPostsList.value = userLike.data!;
      //   postLike(true);
      //   return userLike.data;
      // } else {
      //   postLike(false);
      //   return [];
      // }
    } finally {
      isLoading(false);
    }
  }

  // Future<List<Data>?>
  postCommentedByUser(String postId) async {
    try {
      isLoading(true);

      // PostLikedByUser userLike =
      await PostApi.postCommentedByUser(postId);

      // if (userLike.data?.first.id != null) {
      //   if (userLikedPostsList.isEmpty)
      //     userLikedPostsList.value = userLike.data!;
      //   postLike(true);
      //   return userLike.data;
      // } else {
      //   postLike(false);
      //   return [];
      // }
    } finally {
      isLoading(false);
    }
  }
}
