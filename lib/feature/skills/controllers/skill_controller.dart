import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:mesh/feature/skills/models/active_skills_model.dart';
import 'package:mesh/feature/skills/services/remote_services.dart';

class SkillsController extends GetxController {
  var isLoading = true.obs;
  var skillsList = <ActiveSkillsModel>[].obs;

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
}
