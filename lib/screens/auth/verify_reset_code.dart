/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:49:38
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 17:58:02
 * @Description: 
 */
import 'package:flutter/material.dart';
import '/models/sso_api/dto/auth/verify_reset_code/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/generated/l10n.dart';
import '/widgets/toast.dart';
import '/services/sso_api.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  final String accountName;

  const VerifyResetCodeScreen({super.key, required this.accountName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifyResetCodeForm(accountName: accountName),
    );
  }
}

// 改為 ConsumerStatefulWidget
class VerifyResetCodeForm extends ConsumerStatefulWidget {
  final String accountName;
  const VerifyResetCodeForm({super.key, required this.accountName});

  @override
  ConsumerState<VerifyResetCodeForm> createState() =>
      _VerifyResetCodeFormState();
}

class _VerifyResetCodeFormState extends ConsumerState<VerifyResetCodeForm> {
  final _resetCodeController = TextEditingController();
  bool _accountHasError = false;
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
  Future<void> _verifyResetCode() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _accountHasError = _resetCode.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_accountHasError) {
      return;
    }

    // 呼叫 API
    final ssoApi = SSOApi();
    final response = await ssoApi.verifyResetCode(VerifyResetCodeRequest(
      account: widget.accountName,
      code: _resetCode,
    ));

    if (response.hasError) {
      ToastUtil.showError(errorMessage: response.errors!.first.message);
      return;
    }

    // 跳轉至設定新密碼頁面
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

                    // 提醒文字
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        l10n.verify_code_screen_enter_title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // 驗證碼輸入
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: _resetCodeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: l10n.verify_code_screen_code,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _accountHasError
                              ? l10n.verify_code_screen_code
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

                    // 驗證按鈕
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _verifyResetCode();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(l10n.verify_code_screen_button),
                      ),
                    ),

                    // 返回輸入帳號
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
                            child: Text(l10n.verify_code_screen_resend),
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
