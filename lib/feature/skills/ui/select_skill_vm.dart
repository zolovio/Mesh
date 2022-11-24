import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/auth/domain/model/skill_model.dart';
import 'package:mesh/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:mesh/main.dart';

final selectSkillVmProvider = ChangeNotifierProvider((ref) => SelectSkillVm());

class SelectSkillVm extends ChangeNotifier {
  late AuthUseCase _useCase;

  bool isLoading = true;
  List<SkillModel> skills = [];
  SelectSkillVm() {
    _useCase = AuthUseCase();
    load();
  }

  load() async {
    isLoading = true;
    notifyListeners();
    final result = await _useCase.fetchSkills();
    result?.when(success: (success) {
      skills = success!;
      isLoading = false;
      notifyListeners();
    }, failure: (failure) {
      isLoading = false;
      notifyListeners();
      FlutterToast.show(message: failure!);
    });
  }

  Future<void> onContinueTap() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'firstTimeLogin', value: 'false');
    navigatorKey.currentState?.pushNamed(AppRouter.prepareScreen);
  }
}
