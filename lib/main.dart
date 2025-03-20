/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-20 17:25:10
 * @Description: 
 */

import 'services/settings/api_service_manager.dart';
import 'package:flutter/material.dart';
import 'src/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiServiceManager.init();
  runApp(const TracleDriverApp());
}

class TracleDriverApp extends StatefulWidget {
  const TracleDriverApp({super.key});

  @override
  State<TracleDriverApp> createState() => _TracleDriverAppState();
}

class _TracleDriverAppState extends State<TracleDriverApp> {
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
