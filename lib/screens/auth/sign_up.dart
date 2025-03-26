import 'package:flutter/material.dart';
import '/models/sso_api/dto/auth/sign_up/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/services/sso_api.dart';
import '/widgets/toast.dart';
import './verify_register_code.dart';

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
  // 添加表單 Key
  final _formKey = GlobalKey<FormState>();

  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  late S l10n;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = S.of(context); // 初始化 l10n
  }

  // 電子郵件驗證輔助函數
  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }

  // 提交表單
  Future<void> _submitForm() async {
    // 驗證表單
    if (!_formKey.currentState!.validate()) {
      return; // 如果驗證失敗，直接返回
    }

    // 驗證通過，繼續註冊流程
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

    // 跳轉到驗證頁面
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyRegisterCodeScreen(
          name: _name,
          email: _email,
          password: _password,
          accountName: _account,
        ),
      ),
    );
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
                child: Form(
                  key: _formKey,
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
                        child: TextFormField(
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
                          ),
                          // 帳號驗證器
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.register_screen_account_error;
                            }
                            if (value.length < 6) {
                              return l10n.register_screen_account_length_error;
                            }
                            return null;
                          },
                          // 自動校正設定
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),

                      // 密碼輸入
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
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
                          ),
                          obscureText: true,
                          // 密碼驗證器
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.register_screen_password_error;
                            }
                            if (value.length < 8) {
                              return l10n.register_screen_password_length_error;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),

                      // 姓名輸入
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
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
                          ),
                          // 姓名驗證器
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.register_screen_name_error;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),

                      // 電子郵件輸入
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
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
                          ),
                          // 電子郵件驗證器
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.register_screen_email_error;
                            }
                            if (!_isValidEmail(value)) {
                              return l10n.register_screen_email_format_error;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),

                      // 註冊按鈕
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: _submitForm,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
          ),
        ],
      ),
    );
  }
}
