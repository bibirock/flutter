/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 14:28:59
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 14:34:03
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';
import 'api_module.dart';
import 'api_error.dart';

part 'api_response.g.dart';

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
