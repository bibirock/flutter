/*
 * @Author: Joe.Chen
 * @Date: 2025-03-26 15:55:23
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 16:12:16
 * @Description: 
 */
import 'package:flutter/material.dart';
import '/widgets/loading.dart';
import '/generated/l10n.dart';
import './login.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Logo
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        'assets/images/tracle-logo.png',
                        width: 200,
                        height: 200,
                      ),
                    ),

                    // 提醒文字
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        l10n.register_screen_success,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // 返回登入畫面
                    LoadingButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(l10n.register_screen_login)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
