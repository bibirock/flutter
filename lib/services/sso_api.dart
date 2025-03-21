/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:30:08
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 11:28:04
 * @Description: 
 */
import 'settings/api_service_manager.dart';
import 'package:flutter_application_1/models/sign_in_password.dart';

class SSOApi {
  final _api = ApiServiceManager.ssoApi;

  Future<SignInPassword> signInPassword(String account, String password) async {
    const application = 'TRACLE-APP';
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
}
