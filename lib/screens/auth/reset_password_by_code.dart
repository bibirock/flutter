import 'dart:async';
import '/models/sso_api/dto/auth/reset_password_by_code/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '/providers/loading_provider.dart';
import '/widgets/loading.dart';
import '/generated/l10n.dart';
import '/widgets/toast.dart';
import '/services/sso_api.dart';
import './login.dart';

class ResetPasswordByCodeScreen extends StatelessWidget {
  final String accountName;
  final String token;

  const ResetPasswordByCodeScreen(
      {super.key, required this.accountName, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResetPasswordByCodeFrom(accountName: accountName, token: token),
    );
  }
}

class ResetPasswordByCodeFrom extends ConsumerStatefulWidget {
  final String accountName;
  final String token;
  const ResetPasswordByCodeFrom(
      {super.key, required this.accountName, required this.token});

  @override
  ConsumerState<ResetPasswordByCodeFrom> createState() =>
      _ResetPasswordByCodeFromState();
}

class _ResetPasswordByCodeFromState
    extends ConsumerState<ResetPasswordByCodeFrom> {
  final _passwordController = TextEditingController();
  bool _passwordHasError = false;
  final _loadingService = LoadingService();
  late S l10n;

  String get _password => _passwordController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = S.of(context); // 初始化 l10n
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _passwordHasError = _password.isEmpty;
      _passwordHasError = _password.length < 8;
    });

    // 如果有錯誤，不繼續執行
    if (_passwordHasError) {
      return;
    }

    await _loadingService.withLoading(() async {
      // 呼叫 API
      final ssoApi = SSOApi();
      final response =
          await ssoApi.resetPasswordByCode(ResetPasswordByCodeRequest(
        account: widget.accountName,
        token: widget.token,
        password: _password,
      ));

      if (response.hasError) {
        ToastUtil.showError(errorMessage: response.errors!.first.message);
        return;
      }

      ToastUtil.showSuccess(message: l10n.update_password_screen_success);

      await Future.delayed(const Duration(seconds: 3));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

                    // 新密碼輸入
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.update_password_screen_new_password,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _passwordHasError
                              ? l10n.update_password_screen_format_error
                              : null,
                        ),
                        onChanged: (value) {
                          if (_passwordHasError) {
                            setState(() {
                              _passwordHasError = false;
                            });
                          }
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        l10n.update_password_screen_hint,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('返回')),

                    // 更新密碼按鈕
                    LoadingButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: _updatePassword,
                        child: Text(l10n.common_message_confirm)),
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
