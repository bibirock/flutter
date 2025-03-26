import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '/models/sso_api/dto/auth/verify_register_code/request.dart';
import '/models/sso_api/dto/auth/sign_up/request.dart';
import '/providers/loading_provider.dart';
import '/widgets/loading.dart';
import '/generated/l10n.dart';
import '/widgets/toast.dart';
import '/services/sso_api.dart';
import './register_success.dart';

class VerifyRegisterCodeScreen extends StatelessWidget {
  final String accountName;
  final String password;
  final String email;
  final String name;

  const VerifyRegisterCodeScreen(
      {super.key,
      required this.accountName,
      required this.password,
      required this.email,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifyRegisterCodeFrom(
          accountName: accountName,
          password: password,
          email: email,
          name: name),
    );
  }
}

class VerifyRegisterCodeFrom extends ConsumerStatefulWidget {
  final String accountName;
  final String password;
  final String email;
  final String name;

  const VerifyRegisterCodeFrom(
      {super.key,
      required this.accountName,
      required this.password,
      required this.email,
      required this.name});

  @override
  ConsumerState<VerifyRegisterCodeFrom> createState() =>
      _VerifyRegisterCodeFromState();
}

class _VerifyRegisterCodeFromState
    extends ConsumerState<VerifyRegisterCodeFrom> {
  final _registerCodeController = TextEditingController();
  bool _accountHasError = false;
  final _loadingService = LoadingService();
  late S l10n;
  Timer? _timer;
  int _remainingSeconds = 30;

  String get _registerCode => _registerCodeController.text;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    // 初始化倒數秒數
    _remainingSeconds = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = S.of(context); // 初始化 l10n
  }

  @override
  void dispose() {
    _timer?.cancel();
    _registerCodeController.dispose();
    super.dispose();
  }

  Future<void> _verifyResetCode() async {
    // 檢查欄位並設定錯誤狀態
    setState(() {
      _accountHasError = _registerCode.isEmpty;
    });

    // 如果有錯誤，不繼續執行
    if (_accountHasError) {
      return;
    }

    // 使用 LoadingService 自動管理 loading 狀態
    await _loadingService.withLoading(() async {
      // 呼叫 API
      final ssoApi = SSOApi();
      final response =
          await ssoApi.verifyRegisterCode(VerifyRegisterCodeRequest(
        account: widget.accountName,
        code: _registerCode,
      ));

      if (response.hasError) {
        ToastUtil.showError(errorMessage: response.errors!.first.message);
        return;
      }

      // 前往通知審核頁面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterSuccessScreen(),
        ),
      );
    });
  }

  // 目前重新寄送就是重新註冊
  Future<void> _resendCode() async {
    await _loadingService.withLoading(
      () async {
        final ssoApi = SSOApi();
        final response = await ssoApi.signUp(
          SignUpRequest(
            account: widget.accountName,
            password: widget.password,
            name: widget.name,
            email: widget.email,
          ),
        );

        if (response.hasError) {
          ToastUtil.showError(errorMessage: response.errors!.first.message);
          return;
        }

        // 重新開始倒數
        _startCountdown();
      },
    );
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
                        controller: _registerCodeController,
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
                    LoadingButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: _verifyResetCode,
                        child: Text(l10n.verify_code_screen_button)),

                    // 重新寄送驗證碼 & 倒數計時
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            // 只有倒數結束 (剩餘秒數為 0) 才可點擊
                            onPressed: _remainingSeconds == 0
                                ? () {
                                    _resendCode();
                                    // 若要點擊後重新開始倒數，可呼叫 _startCountdown();
                                  }
                                : null,
                            child: Text(l10n.verify_code_screen_resend),
                          ),
                          const SizedBox(width: 8),
                          // 顯示倒數秒數，倒數中才顯示數字
                          Text(
                            _remainingSeconds > 0 ? '$_remainingSeconds' : '',
                            style: const TextStyle(color: Colors.white),
                          ),
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
