// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPasswordResponse _$VerifyPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyPasswordResponse(
      success: json['success'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyPasswordResponseToJson(
        VerifyPasswordResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
    };
