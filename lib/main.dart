/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 14:01:32
 * @Description: 
 */

import 'services/settings/api_service_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // shared preferences init
  final sharedPreferences = await SharedPreferences.getInstance();

  // api service manager init
  await ApiServiceManager.init();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const TracleDriverApp(),
  ));
}

class TracleDriverApp extends ConsumerStatefulWidget {
  const TracleDriverApp({super.key});

  @override
  ConsumerState<TracleDriverApp> createState() => _TracleDriverAppState();
}

class _TracleDriverAppState extends ConsumerState<TracleDriverApp> {
  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF9AC972)),
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // 登入和登出使用不同的動畫方向
          final isLogin = child is HomeScreen;

          // 為不同頁面設定不同的起始位置
          final begin = isLogin
              ? const Offset(1.0, 0.0) // 登入時從右側滑入
              : const Offset(-1.0, 0.0); // 登出時從左側滑入

          return SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        child: isAuthenticated
            ? const HomeScreen(key: ValueKey('home'))
            : const LoginScreen(key: ValueKey('login')),
      ),
    );
  }
}
