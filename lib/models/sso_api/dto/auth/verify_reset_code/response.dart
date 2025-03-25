/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 16:56:10
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class VerifyResetCodeResponse {
  final bool success;
  final String token;

  VerifyResetCodeResponse({
    required this.success,
    required this.token,
  });

  factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseToJson(this);
}
