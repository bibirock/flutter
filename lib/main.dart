/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-20 15:49:01
 * @Description: 
 */
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'src/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TracleDriverApp());
}

class TracleDriverApp extends StatefulWidget {
  const TracleDriverApp({super.key});

  @override
  State<TracleDriverApp> createState() => _TracleDriverAppState();
}

class _TracleDriverAppState extends State<TracleDriverApp> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    try {
      // 設定遠端配置的預設值
      await _remoteConfig.setDefaults(<String, dynamic>{
        'API_MANAGEMENT_SERVICE_V3':
            'https://management-api-dev.tracle.site/api/management',
        'API_USER_SERVICE_V3': 'https://sso-api.tracle.site',
      });

      // 設定遠端配置的參數
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      // 從遠端獲取並激活配置
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // 處理異常
      print('遠端配置初始化失敗: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF9AC972)),
      home: const Scaffold(
        body: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
