import 'package:flutter/material.dart';
import '../../../services/sso_api.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  // 這裡可以直接讀取 TextField 的內容，
  // 也可以在使用時再去 _accountController.text 取值。
  String get _account => _accountController.text;
  String get _password => _passwordController.text;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 呼叫 API 的登入方法
  Future<void> _login() async {
    final ssoApi = SSOApi();
    try {
      final result = await ssoApi.signInPassword(_account, _password);
      // 成功時顯示登入成功的對話框
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('登入成功'),
            content: Text(
              '帳號: ${result.accountId}\n'
              'Token: ${result.accessToken}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('確定'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // 失敗時顯示錯誤訊息
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('登入失敗'),
            content: Text('錯誤: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('確定'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 設定背景顏色，或可在 theme 中統一設定
      color: const Color(0xFF9AC972),
      // SafeArea 可避免劉海或虛擬按鈕遮擋
      child: SafeArea(
        // 使用 Stack 讓子元件可以自由定位
        child: Stack(
          children: [
            // 1. 主要內容置中
            Center(
              child: SingleChildScrollView(
                // SingleChildScrollView 可以避免在小螢幕時超出範圍
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

                      // 帳號輸入
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: _accountController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '請輸入帳號',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      // 密碼輸入
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '請輸入密碼',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: true,
                      ),

                      // 忘記密碼
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('忘記密碼?'),
                            onPressed: () {
                              print('忘記密碼');
                            },
                          ),
                        ],
                      ),

                      // 登入按鈕
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          _login();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text('登入'),
                        ),
                      ),

                      // 註冊
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('還沒有帳號嗎?'),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('註冊'),
                              onPressed: () {
                                print('註冊');
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. 版號固定在畫面右下角
            Positioned(
              bottom: 16,
              right: 16,
              child: Text(
                '1.8.1(26)',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
