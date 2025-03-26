// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAccountResponse _$RegisterAccountResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterAccountResponse(
      success: json['success'] as bool,
      nextStep: json['nextStep'] as String,
    );

Map<String, dynamic> _$RegisterAccountResponseToJson(
        RegisterAccountResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'nextStep': instance.nextStep,
    };
