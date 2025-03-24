/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 16:46:37
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:33:29
 * @Description: 
 */

import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class SendResetCodeResponse {
  final bool success;

  SendResetCodeResponse({
    required this.success,
  });

  factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendResetCodeResponseToJson(this);
}
