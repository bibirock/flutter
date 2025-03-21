/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:30:08
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 17:31:29
 * @Description: 
 */
import 'settings/api_service_manager.dart';
import '/models/sso_api/auth/sign_in_password.dart';
import '/models/sso_api/auth/access_token_verify.dart';

class SSOApi {
  final _api = ApiServiceManager.ssoApi;
  static const application = 'TRACLE-APP';

  /// 使用帳號密碼登入
  Future<SignInPassword> signInPassword(String account, String password) async {
    const url = "/auth/sign-in/password";

    final response = await _api.dio.post(
      url,
      data: {
        'application': application,
        'account': account,
        'password': password,
      },
    );

    // 驗證成功後，更新 header，以後的請求都會帶上 accessToken
    if (response.statusCode == 200) {
      _api.updateRequestHeader(
          'x-api-key', response.data['data']['accessToken']);
    }

    return SignInPassword.fromJson(response.data);
  }

  /// 驗證 accessToken 是否有使用權限
  Future<AccessTokenVerify> verifyAccessToken() async {
    const url = "/access-token/verify?application=$application";

    final response = await _api.dio.get(url);

    return AccessTokenVerify.fromJson(response.data);
  }
}
