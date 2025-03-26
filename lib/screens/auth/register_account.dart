import 'package:flutter/material.dart';
import '/models/sso_api/dto/auth/sign_up/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/services/sso_api.dart';
import '/providers/auth_provider.dart';
import '/widgets/toast.dart';

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterAccountForm(),
    );
  }
}

class RegisterAccountForm extends ConsumerStatefulWidget {
  const RegisterAccountForm({super.key});

  @override
  ConsumerState<RegisterAccountForm> createState() =>
      _RegisterAccountFormState();
}

class _RegisterAccountFormState extends ConsumerState<RegisterAccountForm> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  // 添加錯誤狀態變數
  bool _accountHasError = false;
  bool _passwordHasError = false;
  bool _nameHasError = false;
  bool _emailHasError = false;

  String get _account => _accountController.text;
  String get _password => _passwordController.text;
  String get _name => _nameController.text;
  String get _email => _emailController.text;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // 修改登入方法，添加驗證邏輯
  Future<void> _login() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _accountHasError = _account.isEmpty;
      _accountHasError = _account.length < 6;
      _passwordHasError = _password.isEmpty;
      _passwordHasError = _password.length < 8;
      _nameHasError = _name.isEmpty;
      _emailHasError = _email.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_accountHasError ||
        _passwordHasError ||
        _nameHasError ||
        _emailHasError) {
      return;
    }

    final ssoApi = SSOApi();

    final result = await ssoApi.signUp(
      SignUpRequest(
        account: _account,
        password: _password,
        name: _name,
        email: _email,
      ),
    );

    // 驗證失敗時顯示錯誤訊息
    if (result.hasError) {
      ToastUtil.showError(errorMessage: result.errors!.first.message);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return SafeArea(
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
                          hintText: l10n.register_screen_account,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _accountHasError
                              ? l10n.register_screen_account_error
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.register_screen_password,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _passwordHasError
                              ? l10n.register_screen_password_error
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
                    ),

                    // 姓名輸入
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.register_screen_name,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _nameHasError
                              ? l10n.register_screen_name_error
                              : null,
                        ),
                        onChanged: (value) {
                          if (_nameHasError) {
                            setState(() {
                              _nameHasError = false;
                            });
                          }
                        },
                      ),
                    ),

                    // 電子郵件輸入
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.register_screen_email,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _emailHasError
                              ? l10n.register_screen_email_error
                              : null,
                        ),
                        onChanged: (value) {
                          if (_emailHasError) {
                            setState(() {
                              _emailHasError = false;
                            });
                          }
                        },
                      ),
                    ),

                    // 註冊按鈕
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(l10n.register_screen_button),
                      ),
                    ),

                    // 返回登入
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(l10n.forget_password_screen_back),
                            onPressed: () {
                              Navigator.pop(context);
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
    );
  }
}
