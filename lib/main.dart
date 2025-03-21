/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 10:59:37
 * @Description: 
 */

import 'services/settings/api_service_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'src/pages/login/login_page.dart';

part 'main.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // api service manager init
  await ApiServiceManager.init();
  runApp(ProviderScope(child: const TracleDriverApp()));
}

@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
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
