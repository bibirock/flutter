/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 14:05:59
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 14:11:33
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  final String code;
  final String message;
  final String name;
  final String type;

  ApiError({
    required this.code,
    required this.message,
    required this.name,
    required this.type,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
