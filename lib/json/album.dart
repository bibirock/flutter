/*
 * @Author: Joe.Chen
 * @Date: 2025-03-18 15:13:48
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-18 15:14:27
 * @Description: 
 */

import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  Album(this.userId, this.id, this.title);

  final int userId;
  final int id;
  final String title;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}