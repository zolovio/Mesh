import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';

class DataController extends GetxController {
  RxString? token;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  getAuthToken() async {
    final controller = HomeController();
    token!.value = (await controller.storage.read(key: 'authTokenData'))!;
  }

  getQuestionLikesById(String qId) {}
}
