/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:30:08
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:23:14
 * @Description: 
 */

import 'settings/api_service_manager.dart';

import '/models/sso_api/core/api_response.dart';

import '/models/sso_api/dto/access_token/response.dart';
import '/models/sso_api/dto/auth/send_reset_code/response.dart';
import '/models/sso_api/dto/auth/send_reset_code/request.dart';
import '/models/sso_api/dto/auth/sign_in_password/response.dart';
import '/models/sso_api/dto/auth/sign_in_password/request.dart';

class SSOApi {
  final _api = ApiServiceManager.ssoApi;
  static const application = 'TRACLE-APP';

  /// 使用帳號密碼登入
  Future<ApiResponse<SignInPasswordResponse>> signInPassword(
      SignInPasswordRequest request) async {
    const url = "/auth/sign-in/password";

    final response = await _api.dio.post(
      url,
      data: request.toJson(),
    );

    final apiResponse = ApiResponse<SignInPasswordResponse>.fromJson(
        response.data,
        (json) =>
            SignInPasswordResponse.fromJson(json as Map<String, dynamic>));

    // 驗證成功後，更新 header，以後的請求都會帶上 accessToken
    if (!apiResponse.hasError && apiResponse.data != null) {
      _api.updateRequestHeader('x-api-key', apiResponse.data!.accessToken);
    }

    return apiResponse;
  }

  /// 驗證 accessToken 是否有使用權限
  Future<ApiResponse<AccessTokenVerifyResponse>> verifyAccessToken() async {
    const url = "/access-token/verify?application=$application";

    final response = await _api.dio.get(url);

    return ApiResponse<AccessTokenVerifyResponse>.fromJson(
        response.data,
        (json) =>
            AccessTokenVerifyResponse.fromJson(json as Map<String, dynamic>));
  }

  /// 送出忘記密碼驗證碼
  Future<ApiResponse<SendResetCodeResponse>> sendResetCode(
      SendResetCodeRequest request) async {
    const url = "/account/reset-code/send";

    final response = await _api.dio.post(
      url,
      data: request.toJson(),
    );

    return ApiResponse<SendResetCodeResponse>.fromJson(response.data,
        (json) => SendResetCodeResponse.fromJson(json as Map<String, dynamic>));
  }
}
