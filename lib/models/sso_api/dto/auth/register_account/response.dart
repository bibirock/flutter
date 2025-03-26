/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:42:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 15:09:37
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class RegisterAccountResponse {
  final bool success;
  final String nextStep;

  RegisterAccountResponse({
    required this.success,
    required this.nextStep,
  });

  factory RegisterAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterAccountResponseToJson(this);
}
