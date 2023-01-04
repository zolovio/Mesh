import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/state_manager.dart';
import 'package:mesh/feature/skills/models/active_skills_model.dart';
import 'package:mesh/feature/skills/services/remote_services.dart';

import '../../../configs/app_router.dart';
import '../../../main.dart';

class SkillsController extends GetxController {
  var isLoading = true.obs;
  var isSaving = false.obs;
  var skillsList = <ActiveSkillsModel>[].obs;
  var selectedskillsList = [].obs;
  final storage = FlutterSecureStorage();
  @override
  void onInit() {
    fetchSkills();
    super.onInit();
  }

  void fetchSkills() async {
    try {
      isLoading(true);
      var activeskills = await RemoteServices.fetchactiveskills();
      // print('active skills: ${activeskills.id}');
      if (activeskills != null) {
        skillsList.clear();
        for (var skill in activeskills['data']) {
          skillsList.add(ActiveSkillsModel.fromJson(skill));
        }
        if (kDebugMode) {
          print(skillsList[0].selected);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void updateSkills({required String userid}) async {
    if (kDebugMode) {
      print('selected skills: ${selectedskillsList}');
    }
    List selectedskills = [];
    selectedskillsList.forEach((element) {
      selectedskills.add({"skill_id": element.toString()});
    });
    print(selectedskills);
    try {
      isSaving(true);
      var res = await RemoteServices.updateactiveskills(skillids: selectedskills, uid: userid);
      if (res != null) {
        navigatorKey.currentState?.pushNamed(AppRouter.prepareScreen);
      }
    } finally {
      isSaving(false);
    }
  }
}
