/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-20 15:15:43
 * @Description: 
 */

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/login/login_page.dart';

void main() => runApp(const TracleDriverApp());

class TracleDriverApp extends StatefulWidget {
  const TracleDriverApp({super.key});

  @override
  State<TracleDriverApp> createState() => _TracleDriverAppState();
}

class _TracleDriverAppState extends State<TracleDriverApp> {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    super.initState();

    // 遠端設定預設值
    _remoteConfig.setDefaults(<String, dynamic>{
      'API_MANAGEMENT_SERVICE_V3':
          'https://management-api-dev.tracle.site/api/management',
      'API_USER_SERVICE_V3': 'https://sso-api.tracle.site',
    });

    // 遠端設定初始化
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF9AC972)),
      home: Scaffold(
        body: const Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
