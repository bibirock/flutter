/*
 * @Author: Joe.Chen
 * @Date: 2025-03-18 13:47:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-18 14:00:35
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';
import './user_profile.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(this.name, this.email, this.id, this.age, this.profile);

  final String name;
  final String email;
  final int id;
  final int? age;
  final UserProfile profile;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

