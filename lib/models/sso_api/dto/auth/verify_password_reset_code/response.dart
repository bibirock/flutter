/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 18:42:11
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class VerifyPasswordResponse {
  final bool success;
  final String token;

  VerifyPasswordResponse({
    required this.success,
    required this.token,
  });

  factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPasswordResponseToJson(this);
}
