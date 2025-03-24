/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:17:17
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class SignInPasswordResponse {
  final String accountId;
  final String accessToken;

  SignInPasswordResponse({
    required this.accountId,
    required this.accessToken,
  });

  factory SignInPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInPasswordResponseToJson(this);
}
