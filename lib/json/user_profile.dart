/*
 * @Author: Joe.Chen
 * @Date: 2025-03-18 13:58:13
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-18 13:58:53
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  UserProfile(this.name, this.email, this.id, this.age);

  final String name;
  final String email;
  final int id;
  final int? age;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}