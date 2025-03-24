// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult<T> _$SearchResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SearchResult<T>(
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$SearchResultToJson<T>(
  SearchResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data.map(toJsonT).toList(),
    };
