/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-19 17:03:17
 * @Description: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/login/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF9AC972)),
        home: Scaffold(
            body: const Center(
          child: LoginForm(),
        )));
  }
}
