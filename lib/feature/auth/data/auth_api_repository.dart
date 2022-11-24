import 'package:dio/dio.dart';
import 'package:mesh/common/api_result.dart';
import 'package:mesh/common/dio_client.dart';
import 'package:mesh/common/dio_network_exceptions.dart';
import 'package:mesh/common/error_res_model.dart';
import 'package:mesh/common/response.dart';
import 'package:mesh/configs/api_end_point.dart';
import 'package:mesh/feature/auth/domain/interface/i_auth_api_repository.dart';
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/auth/domain/model/skill_model.dart';
import 'package:mesh/feature/auth/domain/model/user_res_model.dart';

class AuthApiRepository implements IAuthApiRepository {
  late DioClient _client;

  AuthApiRepository({DioClient? dioClient}) {
    _client = dioClient ?? DioClient(APIEndpoints.baseUrl);
  }

  @override
  Future<ApiResult<UserResModel>> signUp({
    required String username,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = ApiResponse.parse(
        await _client.post(
          APIEndpoints.users,
          options: Options(headers: {
            "Connection": "keep-alive",
          }),
          data: {
            "email": username,
            "password": password,
            "role": "98c76b32-94a7-4308-96e8-8a93248c9b58",
            "first_name": firstName,
            "last_name": lastName,
          },
        ),
      );
      return ApiResult.success(data: UserResModel.fromJson(response.data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        ErrorResModel errorResModel = ErrorResModel.fromJson(e.response?.data);
        return ApiResult.failure(message: errorResModel.errors!.first.message!);
      } else {
        return ApiResult.networkFailure(
            error: DioNetworkExceptions.getDioException(e));
      }
    }
  }

  @override
  Future<ApiResult<AuthTokenModel>> login(
      {required String username, required String password}) async {
    try {
      final response = ApiResponse.parse(
        await _client.post(
          APIEndpoints.login,
          options: Options(headers: {
            "Connection": "keep-alive",
          }),
          data: {"email": username, "password": password},
        ),
      );
      return ApiResult.success(data: AuthTokenModel.fromJson(response.data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        ErrorResModel errorResModel = ErrorResModel.fromJson(e.response?.data);
        return ApiResult.failure(message: errorResModel.errors!.first.message!);
      } else {
        return ApiResult.networkFailure(
            error: DioNetworkExceptions.getDioException(e));
      }
    }
  }

  @override
  Future<ApiResult<List<UserResModel>>> getUser(
      {required String username}) async {
    try {
      final response = //ApiResponse.parse(
          await _client.get(
        APIEndpoints.getUser + username,
        options: Options(headers: {
          "Connection": "keep-alive",
        }),
        // ),
      );
      List<UserResModel> list =
          (response.data as List).map((e) => UserResModel.fromJson(e)).toList();
      return ApiResult.success(data: list);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        ErrorResModel errorResModel = ErrorResModel.fromJson(e.response?.data);
        return ApiResult.failure(message: errorResModel.errors!.first.message!);
      } else {
        return ApiResult.networkFailure(
            error: DioNetworkExceptions.getDioException(e));
      }
    }
  }

  @override
  Future<ApiResult<List<SkillModel>>> fetchSkills() async {
    try {
      final response = //ApiResponse.parse(
          await _client.get(
        APIEndpoints.skills,
        options: Options(headers: {
          "Connection": "keep-alive",
        }),
        // ),
      );

      List<SkillModel> list =
          (response.data as List).map((e) => SkillModel.fromJson(e)).toList();
      return ApiResult.success(data: list);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        ErrorResModel errorResModel = ErrorResModel.fromJson(e.response?.data);
        return ApiResult.failure(message: errorResModel.errors!.first.message!);
      } else {
        return ApiResult.networkFailure(
            error: DioNetworkExceptions.getDioException(e));
      }
    }
  }
}
