// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInPasswordResponse _$SignInPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    SignInPasswordResponse(
      accountId: json['accountId'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$SignInPasswordResponseToJson(
        SignInPasswordResponse instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'accessToken': instance.accessToken,
    };
