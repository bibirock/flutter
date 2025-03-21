/*
 * @Author: Joe.Chen
 * @Date: 2025-03-21 17:00:55
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 17:04:24
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'access_token_verify.g.dart';

@JsonSerializable()
class AccessTokenVerify {
  AccessTokenVerify(this.success, this.userAccountId);

  final bool success;
  final String userAccountId;

  factory AccessTokenVerify.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return _$AccessTokenVerifyFromJson(data);
  }

  Map<String, dynamic> toJson() => _$AccessTokenVerifyToJson(this);
}
