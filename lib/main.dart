/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 13:35:48
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
      home: Scaffold(
        body: Center(
          child: isAuthenticated ? HomeScreen() : LoginForm(),
        ),
      ),
    );
  }
}
