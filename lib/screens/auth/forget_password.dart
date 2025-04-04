import 'package:flutter/material.dart';
import '/providers/loading_provider.dart';
import '/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/models/sso_api/dto/auth/send_reset_code/request.dart';
import '/widgets/toast.dart';
import '/services/sso_api.dart';
import 'verify_reset_code.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgetPasswordForm(),
    );
  }
}

class ForgetPasswordForm extends ConsumerStatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  ConsumerState<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends ConsumerState<ForgetPasswordForm> {
  final _resetCodeController = TextEditingController();
  final _loadingService = LoadingService();
  bool _resetCodeHasError = false;
  late S l10n;

  String get _resetCode => _resetCodeController.text;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = S.of(context); // 初始化 l10n
  }

  @override
  void dispose() {
    _resetCodeController.dispose();
    super.dispose();
  }

  // 修改登入方法，添加驗證邏輯
  Future<void> _sendResetCodeEmail() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _resetCodeHasError = _resetCode.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_resetCodeHasError) {
      return;
    }

    // 使用 LoadingService 自動管理 loading 狀態
    await _loadingService.withLoading(() async {
      // 呼叫 API
      final ssoApi = SSOApi();
      final response = await ssoApi.sendResetCode(SendResetCodeRequest(
        account: _resetCode,
      ));

      if (response.hasError) {
        ToastUtil.showError(errorMessage: response.errors!.first.message);
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyResetCodeScreen(accountName: _resetCode),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        controller: _resetCodeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.forget_password_screen_enter_account,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _resetCodeHasError
                              ? l10n.forget_password_screen_enter_account
                              : null,
                        ),
                        onChanged: (value) {
                          if (_resetCodeHasError) {
                            setState(() {
                              _resetCodeHasError = false;
                            });
                          }
                        },
                      ),
                    ),

                    LoadingButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: _sendResetCodeEmail,
                        child: Text(l10n.forget_password_screen_send_email)),

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
