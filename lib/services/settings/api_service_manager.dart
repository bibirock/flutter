/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:25:33
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-20 16:32:32
 * @Description: 
 */

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'api_service.dart';

class ApiServiceManager {
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  static late ApiService managementApi;
  static late ApiService ssoApi;

  static const String _defaultManagementUrl =
      'https://management-api-dev.tracle.site/api/management';
  static const String _defaultUserUrl = 'https://sso-api.tracle.site';

  static Future<void> init() async {
    try {
      await _remoteConfig.setDefaults({
        'API_MANAGEMENT_SERVICE_V3': _defaultManagementUrl,
        'API_USER_SERVICE_V3': _defaultUserUrl,
      });

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('RemoteConfig 載入失敗，使用預設值：$e');
    }

    managementApi = ApiService(
      _remoteConfig.getString('API_MANAGEMENT_SERVICE_V3'),
    );

    ssoApi = ApiService(
      _remoteConfig.getString('API_USER_SERVICE_V3'),
    );
  }

  static Future<void> refresh() async {
    try {
      await _remoteConfig.fetchAndActivate();
      managementApi.updateBaseUrl(
        _remoteConfig.getString('API_MANAGEMENT_SERVICE_V3'),
      );
      ssoApi.updateBaseUrl(
        _remoteConfig.getString('API_USER_SERVICE_V3'),
      );
    } catch (e) {
      print('RemoteConfig 更新失敗：$e');
    }
  }
}
