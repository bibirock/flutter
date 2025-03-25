// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyResetCodeResponse _$VerifyResetCodeResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyResetCodeResponse(
      success: json['success'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyResetCodeResponseToJson(
        VerifyResetCodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
    };
