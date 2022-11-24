import 'package:mesh/common/api_result.dart';
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/auth/domain/model/skill_model.dart';
import 'package:mesh/feature/auth/domain/model/user_res_model.dart';

abstract class IAuthApiRepository {
  Future<ApiResult<AuthTokenModel>> login(
      {required String username, required String password});
  Future<ApiResult<UserResModel>> signUp(
      {required String username,
      required String password,
      String? firstName,
      String? lastName});
  Future<ApiResult<List<UserResModel>>> getUser({required String username});

  Future<ApiResult<List<SkillModel>>> fetchSkills();
}
