/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 11:29:27
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 13:30:19
 * @Description: 
 */

import 'package:json_annotation/json_annotation.dart';

part 'api_module.g.dart';

@JsonSerializable()
class ApiModule {
  final String code;
  final String name;
  final String version;

  ApiModule({
    required this.code,
    required this.name,
    required this.version,
  });

  factory ApiModule.fromJson(Map<String, dynamic> json) =>
      _$ApiModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ApiModuleToJson(this);
}
