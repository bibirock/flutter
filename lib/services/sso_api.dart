/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:30:08
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 15:31:32
 * @Description:  SSO API 服務
 */

import 'settings/api_service_manager.dart';

import '/models/sso_api/core/api_response.dart';

import '/models/sso_api/dto/auth/access_token/response.dart';
import '/models/sso_api/dto/auth/send_reset_code/response.dart';
import '/models/sso_api/dto/auth/send_reset_code/request.dart';
import '/models/sso_api/dto/auth/sign_in_password/response.dart';
import '/models/sso_api/dto/auth/sign_in_password/request.dart';
import '/models/sso_api/dto/auth/verify_reset_code/response.dart';
import '/models/sso_api/dto/auth/verify_reset_code/request.dart';
import '/models/sso_api/dto/auth/reset_password_by_code/request.dart';
import '/models/sso_api/dto/auth/reset_password_by_code/response.dart';
import '/models/sso_api/dto/auth/sign_up/request.dart';
import '/models/sso_api/dto/auth/sign_up/response.dart';
import '/models/sso_api/dto/auth/verify_register_code/request.dart';
import '/models/sso_api/dto/auth/verify_register_code/response.dart';
import 'package:dio/dio.dart';

class SSOApi {
  final _api = ApiServiceManager.ssoApi;
  static const application = 'TRACLE-APP';

  // 發送請求統一格式
  Future<ApiResponse<T>> _sendRequest<T>({
    required String url,
    required String method,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _api.dio.get(url, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await _api.dio
              .post(url, data: data, queryParameters: queryParameters);
          break;
        // 可以根據需要添加其他HTTP方法
        default:
          throw Exception('不支援的HTTP方法: $method');
      }

      return ApiResponse<T>.fromJson(
          response.data, (json) => fromJson(json as Map<String, dynamic>));
    } catch (e) {
      return ApiResponse<T>.error(
        errorCode: 'unknown_error',
        errorMessage: 'error: ${e.toString()}',
      );
    }
  }

  // 使用帳號密碼登入
  Future<ApiResponse<SignInPasswordResponse>> signInPassword(
      SignInPasswordRequest request) async {
    final apiResponse = await _sendRequest<SignInPasswordResponse>(
      url: "/auth/sign-in/password",
      method: 'POST',
      data: request.toJson(),
      fromJson: SignInPasswordResponse.fromJson,
    );

    // 驗證成功後，更新 header，以後的請求都會帶上 accessToken
    if (!apiResponse.hasError && apiResponse.data != null) {
      _api.updateRequestHeader('x-api-key', apiResponse.data!.accessToken);
    }

    return apiResponse;
  }

  // 驗證 accessToken 是否有使用權限
  Future<ApiResponse<AccessTokenVerifyResponse>> verifyAccessToken() async {
    return _sendRequest<AccessTokenVerifyResponse>(
      url: "/access-token/verify",
      method: 'GET',
      queryParameters: {'application': application},
      fromJson: AccessTokenVerifyResponse.fromJson,
    );
  }

  // 送出忘記密碼驗證碼
  Future<ApiResponse<SendResetCodeResponse>> sendResetCode(
      SendResetCodeRequest request) async {
    return _sendRequest<SendResetCodeResponse>(
      url: "/sso-web/forget-password",
      method: 'POST',
      data: request.toJson(),
      fromJson: SendResetCodeResponse.fromJson,
    );
  }

  // 驗證忘記密碼驗證碼
  Future<ApiResponse<VerifyResetCodeResponse>> verifyResetCode(
      VerifyResetCodeRequest request) async {
    return _sendRequest<VerifyResetCodeResponse>(
      url: "/verification/password/reset/number",
      method: 'POST',
      data: request.toJson(),
      fromJson: VerifyResetCodeResponse.fromJson,
    );
  }

  // 使用碼驗證碼重設密碼
  Future<ApiResponse<ResetPasswordByCodeResponse>> resetPasswordByCode(
      ResetPasswordByCodeRequest request) async {
    return _sendRequest<ResetPasswordByCodeResponse>(
      url: "/sso-web/reset-password",
      method: 'POST',
      data: request.toJson(),
      fromJson: ResetPasswordByCodeResponse.fromJson,
    );
  }

  // 註冊帳號
  Future<ApiResponse<SignUpResponse>> signUp(SignUpRequest request) async {
    return _sendRequest<SignUpResponse>(
      url: "/sso-web/sign-up",
      method: 'POST',
      data: request.toJson(),
      fromJson: SignUpResponse.fromJson,
    );
  }

  // 驗證電子郵件註冊碼
  Future<ApiResponse<VerifyRegisterCodeResponse>> verifyRegisterCode(
      VerifyRegisterCodeRequest request) async {
    return _sendRequest<VerifyRegisterCodeResponse>(
      url: "/verification/register/code",
      method: 'POST',
      data: request.toJson(),
      fromJson: VerifyRegisterCodeResponse.fromJson,
    );
  }
}
