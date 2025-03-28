/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 14:36:40
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResetPasswordByCodeResponse {
  final bool success;

  ResetPasswordByCodeResponse({
    required this.success,
  });

  factory ResetPasswordByCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordByCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordByCodeResponseToJson(this);
}
