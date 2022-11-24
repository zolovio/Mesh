import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T? data}) = Success<T>;

  const factory ApiResult.networkFailure({required NetworkExceptions error}) =
      NetworkFailure<T>;

  const factory ApiResult.failure({required String? message}) = Failure<T>;
}
