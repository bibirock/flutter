/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 14:28:59
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 13:54:15
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';
import 'api_module.dart';
import 'api_error.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final ApiModule module;
  final List<ApiError>? errors;
  final T? data;

  ApiResponse({
    required this.module,
    this.errors,
    this.data,
  });

  bool get hasError => errors != null && errors!.isNotEmpty;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse(
      module: ApiModule.fromJson(json['module'] as Map<String, dynamic>),
      errors: json.containsKey('errors')
          ? (json['errors'] as List<dynamic>)
              .map((e) => ApiError.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      data: json.containsKey('data') ? fromJsonT(json['data']) : null,
    );
  }

  factory ApiResponse.error({
    required String errorCode,
    required String errorMessage,
    String errorName = "API_ERROR",
    String errorType = "ERROR",
    String moduleCode = "ERROR",
    String moduleName = "API_MODULE",
    String moduleVersion = "1.0",
  }) {
    return ApiResponse(
      module: ApiModule(
        code: moduleCode,
        name: moduleName,
        version: moduleVersion,
      ),
      errors: [
        ApiError(
          code: errorCode,
          message: errorMessage,
          name: errorName,
          type: errorType,
        ),
      ],
      data: null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final Map<String, dynamic> result = {
      'module': module.toJson(),
    };

    if (errors != null) {
      result['errors'] = errors!.map((e) => e.toJson()).toList();
    }

    if (data != null) {
      result['data'] = toJsonT(data as T);
    }

    return result;
  }
}
