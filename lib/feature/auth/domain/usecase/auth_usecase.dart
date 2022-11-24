import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mesh/common/usecase_result.dart';
import 'package:mesh/configs/api_end_point.dart';
import 'package:mesh/feature/auth/data/auth_api_repository.dart';
import 'package:mesh/feature/auth/domain/interface/i_auth_api_repository.dart';
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/auth/domain/model/skill_model.dart';
import 'package:mesh/feature/auth/domain/model/user_res_model.dart';

class AuthUseCase {
  late IAuthApiRepository _repository;

  AuthUseCase() {
    _repository = GetIt.instance.get<AuthApiRepository>();
  }

  Future<UsecaseResult<AuthTokenModel>?> login(username, password) async {
    const storage = FlutterSecureStorage();
    final apiResult =
        await _repository.login(username: username, password: password);
    UsecaseResult<AuthTokenModel>? usecaseResult;
    apiResult.when(success: (success) async {
      usecaseResult = UsecaseResult.success(data: success);
      APIEndpoints.authTokenData = success;
      await storage.write(
          key: 'authTokenData', value: AuthTokenModel.serialize(success!));
    }, networkFailure: (networkFailure) {
      usecaseResult =
          const UsecaseResult.failure(error: 'Something went wrong');
    }, failure: (failure) {
      usecaseResult = UsecaseResult.failure(error: failure);
    });
    return usecaseResult;
  }

  Future<UsecaseResult<UserResModel>?> signUp(
      {required String username,
      required String password,
      String? firstName,
      String? lastName}) async {
    final apiResult = await _repository.signUp(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName);
    UsecaseResult<UserResModel>? usecaseResult;
    apiResult.when(success: (success) {
      usecaseResult = UsecaseResult.success(data: success);
    }, networkFailure: (networkFailure) {
      usecaseResult =
          const UsecaseResult.failure(error: 'Something went wrong');
    }, failure: (failure) {
      usecaseResult = UsecaseResult.failure(error: failure);
    });
    return usecaseResult;
  }

  Future<UsecaseResult<List<UserResModel>>?> getUser(
      {required String username}) async {
    final apiResult = await _repository.getUser(username: username);
    UsecaseResult<List<UserResModel>>? usecaseResult;
    apiResult.when(success: (success) {
      usecaseResult = UsecaseResult.success(data: success);
    }, networkFailure: (networkFailure) {
      usecaseResult =
          const UsecaseResult.failure(error: 'Something went wrong');
    }, failure: (failure) {
      usecaseResult = UsecaseResult.failure(error: failure);
    });
    return usecaseResult;
  }

  Future<UsecaseResult<List<SkillModel>>?> fetchSkills() async {
    final apiResult = await _repository.fetchSkills();
    UsecaseResult<List<SkillModel>>? usecaseResult;
    apiResult.when(success: (success) {
      usecaseResult = UsecaseResult.success(data: success);
    }, networkFailure: (networkFailure) {
      usecaseResult =
          const UsecaseResult.failure(error: 'Something went wrong');
    }, failure: (failure) {
      usecaseResult = UsecaseResult.failure(error: failure);
    });
    return usecaseResult;
  }
}
