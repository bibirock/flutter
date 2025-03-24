/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 14:13:16
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 14:28:16
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class SearchResult<T> {
  final int count;
  final List<T> data;

  SearchResult({
    required this.count,
    required this.data,
  });

  factory SearchResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return SearchResult(
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'count': count,
      'data': data.map((e) => toJsonT(e)).toList(),
    };
  }
}
