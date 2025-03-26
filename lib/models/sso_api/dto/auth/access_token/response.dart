/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:17:44
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:17:54
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class AccessTokenVerifyResponse {
  final bool success;
  final String userAccountId;

  AccessTokenVerifyResponse({
    required this.success,
    required this.userAccountId,
  });

  factory AccessTokenVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenVerifyResponseToJson(this);
}
