// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenVerify _$AccessTokenVerifyFromJson(Map<String, dynamic> json) =>
    AccessTokenVerify(
      success: json['success'] as bool,
      userAccountId: json['userAccountId'] as String,
    );

Map<String, dynamic> _$AccessTokenVerifyToJson(AccessTokenVerify instance) =>
    <String, dynamic>{
      'success': instance.success,
      'userAccountId': instance.userAccountId,
    };
