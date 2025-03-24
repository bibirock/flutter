import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/services/sso_api.dart';
import '/providers/auth_provider.dart';
import '../../widgets/toast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}

// 改為 ConsumerStatefulWidget
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

// 改為 ConsumerState
class _LoginFormState extends ConsumerState<LoginForm> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  // 添加錯誤狀態變數
  bool _accountHasError = false;
  bool _passwordHasError = false;

  String get _account => _accountController.text;
  String get _password => _passwordController.text;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 修改登入方法，添加驗證邏輯
  Future<void> _login() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _accountHasError = _account.isEmpty;
      _passwordHasError = _password.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_accountHasError || _passwordHasError) {
      return;
    }

    final ssoApi = SSOApi();

    final result = await ssoApi.signInPassword(_account, _password);

    // 驗證失敗時顯示錯誤訊息
    if (result.hasError) {
      ToastUtil.showError(errorMessage: result.errors!.first.message);
      return;
    }

    // 使用 AuthNotifier 儲存登入資訊
    ref.read(authProvider.notifier).signIn(
          result.data!.accessToken,
          result.data!.accountId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    ToastUtil.init(context);

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
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: l10n.login_screen_enter_account,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide.none,
                            ),
                            errorText: _accountHasError
                                ? l10n.login_screen_enter_account
                                : null,
                          ),
                          onChanged: (value) {
                            if (_accountHasError) {
                              setState(() {
                                _accountHasError = false;
                              });
                            }
                          },
                        ),
                      ),

                      // 密碼輸入
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.login_screen_enter_password,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _passwordHasError
                              ? l10n.login_screen_enter_password
                              : null,
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          if (_passwordHasError) {
                            setState(() {
                              _passwordHasError = false;
                            });
                          }
                        },
                      ),

                      // 忘記密碼
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: Text(l10n.login_screen_forgot_password),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(l10n.login_screen_button),
                        ),
                      ),

                      // 註冊
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(l10n.login_screen_no_account),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(l10n.login_screen_register),
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
