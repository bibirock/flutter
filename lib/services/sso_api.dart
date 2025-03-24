/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:30:08
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 15:13:10
 * @Description: 
 */
import 'package:flutter_application_1/models/sso_api/core/api_error.dart';
import 'package:flutter_application_1/models/sso_api/core/api_module.dart';

import 'settings/api_service_manager.dart';
import '/models/sso_api/core/api_response.dart';
import '/models/sso_api/auth/sign_in_password.dart';
import '../models/sso_api/access_token/access_token_verify.dart';

class SSOApi {
  final _api = ApiServiceManager.ssoApi;
  static const application = 'TRACLE-APP';

  /// 使用帳號密碼登入
  Future<ApiResponse<SignInPassword>> signInPassword(
      String account, String password) async {
    const url = "/auth/sign-in/password";

    final response = await _api.dio.post(
      url,
      data: {
        'application': application,
        'account': account,
        'password': password,
      },
    );

    final apiResponse = ApiResponse<SignInPassword>.fromJson(response.data,
        (json) => SignInPassword.fromJson(json as Map<String, dynamic>));

    // 驗證成功後，更新 header，以後的請求都會帶上 accessToken
    if (!apiResponse.hasError && apiResponse.data != null) {
      _api.updateRequestHeader('x-api-key', apiResponse.data!.accessToken);
    }

    return apiResponse;
  }

  /// 驗證 accessToken 是否有使用權限
  Future<ApiResponse<AccessTokenVerify>> verifyAccessToken() async {
    const url = "/access-token/verify?application=$application";

    final response = await _api.dio.get(url);

    return ApiResponse<AccessTokenVerify>.fromJson(response.data,
        (json) => AccessTokenVerify.fromJson(json as Map<String, dynamic>));
  }
}
