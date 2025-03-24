/*
 * @Author: Joe.Chen
 * @Date: 2025-03-21 17:00:55
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 14:45:14
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'access_token_verify.g.dart';

@JsonSerializable()
class AccessTokenVerify {
  final bool success;
  final String userAccountId;

  AccessTokenVerify({
    required this.success,
    required this.userAccountId,
  });

  factory AccessTokenVerify.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenVerifyFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenVerifyToJson(this);
}
