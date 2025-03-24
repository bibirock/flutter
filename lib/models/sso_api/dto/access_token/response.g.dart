// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenVerifyResponse _$AccessTokenVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    AccessTokenVerifyResponse(
      success: json['success'] as bool,
      userAccountId: json['userAccountId'] as String,
    );

Map<String, dynamic> _$AccessTokenVerifyResponseToJson(
        AccessTokenVerifyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'userAccountId': instance.userAccountId,
    };
