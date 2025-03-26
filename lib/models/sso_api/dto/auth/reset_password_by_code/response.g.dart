// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordByCodeResponse _$ResetPasswordByCodeResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordByCodeResponse(
      success: json['success'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$ResetPasswordByCodeResponseToJson(
        ResetPasswordByCodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
    };
