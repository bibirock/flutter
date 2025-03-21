/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 17:28:32
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_password.g.dart';

@JsonSerializable()
class SignInPassword {
  SignInPassword(this.accountId, this.accessToken);

  final String accountId;
  final String accessToken;

  factory SignInPassword.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data;

    if (json.containsKey('errors')) {
      data = json['errors'] as Map<String, dynamic>;
    }
    data = json['data'] as Map<String, dynamic>;
    return _$SignInPasswordFromJson(data);
  }

  Map<String, dynamic> toJson() => _$SignInPasswordToJson(this);
}
