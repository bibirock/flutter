/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 15:30:14
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class VerifyRegisterCodeResponse {
  final bool success;

  VerifyRegisterCodeResponse({
    required this.success,
  });

  factory VerifyRegisterCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyRegisterCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRegisterCodeResponseToJson(this);
}
