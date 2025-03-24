import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/models/sso_api/dto/auth/send_reset_code/request.dart';
import '/widgets/toast.dart';
import '/services/sso_api.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgetPasswordForm(),
    );
  }
}

// 改為 ConsumerStatefulWidget
class ForgetPasswordForm extends ConsumerStatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  ConsumerState<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

// 改為 ConsumerState
class _ForgetPasswordFormState extends ConsumerState<ForgetPasswordForm> {
  final _accountController = TextEditingController();
  bool _accountHasError = false;
  late S l10n;

  String get _account => _accountController.text;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = S.of(context); // 初始化 l10n
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  // 修改登入方法，添加驗證邏輯
  Future<void> _forgetPassword() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _accountHasError = _account.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_accountHasError) {
      return;
    }

    // 呼叫 API
    final ssoApi = SSOApi();
    final response = await ssoApi.sendResetCode(SendResetCodeRequest(
      account: _account,
    ));

    if (response.hasError) {
      ToastUtil.showError(errorMessage: response.errors!.first.message);
      return;
    }

    ToastUtil.showSuccess(message: l10n.forget_password_screen_email_sent);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    ToastUtil.init(context);

    return SafeArea(
      // 使用 Stack 讓子元件可以自由定位
      child: Stack(
        children: [
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
                          hintText: l10n.forget_password_screen_enter_account,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _accountHasError
                              ? l10n.forget_password_screen_enter_account
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

                    // 登入按鈕
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _forgetPassword();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(l10n.forget_password_screen_send_email),
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
        ],
      ),
    );
  }
}
