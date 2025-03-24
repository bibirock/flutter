/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 14:42:49
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_password.g.dart';

@JsonSerializable()
class SignInPassword {
  final String accountId;
  final String accessToken;

  SignInPassword({
    required this.accountId,
    required this.accessToken,
  });

  factory SignInPassword.fromJson(Map<String, dynamic> json) =>
      _$SignInPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$SignInPasswordToJson(this);
}
