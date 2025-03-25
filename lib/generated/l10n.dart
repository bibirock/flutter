// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `使用者名稱`
  String get login_screen_username {
    return Intl.message(
      '使用者名稱',
      name: 'login_screen_username',
      desc: '登入頁面上使用者名稱輸入欄位的標籤文字',
      args: [],
    );
  }

  /// `密碼`
  String get login_screen_password {
    return Intl.message(
      '密碼',
      name: 'login_screen_password',
      desc: '登入頁面上密碼輸入欄位的標籤文字',
      args: [],
    );
  }

  /// `登入`
  String get login_screen_button {
    return Intl.message(
      '登入',
      name: 'login_screen_button',
      desc: '登入按鈕文字',
      args: [],
    );
  }

  /// `請輸入帳號`
  String get login_screen_enter_account {
    return Intl.message(
      '請輸入帳號',
      name: 'login_screen_enter_account',
      desc: '提示使用者必須輸入帳號的訊息',
      args: [],
    );
  }

  /// `請輸入密碼`
  String get login_screen_enter_password {
    return Intl.message(
      '請輸入密碼',
      name: 'login_screen_enter_password',
      desc: '提示使用者必須輸入密碼的訊息',
      args: [],
    );
  }

  /// `忘記密碼`
  String get login_screen_forgot_password {
    return Intl.message(
      '忘記密碼',
      name: 'login_screen_forgot_password',
      desc: '忘記密碼連結文字',
      args: [],
    );
  }

  /// `還沒有帳號嗎`
  String get login_screen_no_account {
    return Intl.message(
      '還沒有帳號嗎',
      name: 'login_screen_no_account',
      desc: '詢問使用者是否尚未註冊帳號的提示',
      args: [],
    );
  }

  /// `註冊`
  String get login_screen_register {
    return Intl.message(
      '註冊',
      name: 'login_screen_register',
      desc: '註冊帳號的按鈕或連結文字',
      args: [],
    );
  }

  /// `登入失敗，請檢查帳號密碼`
  String get login_screen_error {
    return Intl.message(
      '登入失敗，請檢查帳號密碼',
      name: 'login_screen_error',
      desc: '登入失敗的提示文字',
      args: [],
    );
  }

  /// `帳號無使用權限，請聯絡管理員`
  String get login_screen_permission_denied {
    return Intl.message(
      '帳號無使用權限，請聯絡管理員',
      name: 'login_screen_permission_denied',
      desc: '帳號無使用權限的提示文字',
      args: [],
    );
  }

  /// `寄出重設密碼信`
  String get forget_password_screen_send_email {
    return Intl.message(
      '寄出重設密碼信',
      name: 'forget_password_screen_send_email',
      desc: '忘記密碼頁面上寄出重設密碼信的按鈕文字',
      args: [],
    );
  }

  /// `請輸入註冊時的帳號`
  String get forget_password_screen_enter_account {
    return Intl.message(
      '請輸入註冊時的帳號',
      name: 'forget_password_screen_enter_account',
      desc: '提示使用者必須輸入註冊時的帳號的訊息',
      args: [],
    );
  }

  /// `返回登入畫面`
  String get forget_password_screen_back {
    return Intl.message(
      '返回登入畫面',
      name: 'forget_password_screen_back',
      desc: '返回登入畫面的按鈕文字',
      args: [],
    );
  }

  /// `已發送重設密碼信件`
  String get forget_password_screen_email_sent {
    return Intl.message(
      '已發送重設密碼信件',
      name: 'forget_password_screen_email_sent',
      desc: '重設密碼信已寄出的提示文字',
      args: [],
    );
  }

  /// `請輸入驗證碼`
  String get verify_register_screen_code {
    return Intl.message(
      '請輸入驗證碼',
      name: 'verify_register_screen_code',
      desc: '驗證註冊頁面上驗證碼輸入欄位的標籤文字',
      args: [],
    );
  }

  /// `驗證`
  String get verify_register_screen_button {
    return Intl.message(
      '驗證',
      name: 'verify_register_screen_button',
      desc: '驗證註冊按鈕文字',
      args: [],
    );
  }

  /// `載入中...`
  String get common_message_loading {
    return Intl.message(
      '載入中...',
      name: 'common_message_loading',
      desc: '通用的載入中提示文字',
      args: [],
    );
  }

  /// `發生錯誤，請稍後再試`
  String get common_message_error {
    return Intl.message(
      '發生錯誤，請稍後再試',
      name: 'common_message_error',
      desc: '通用的錯誤提示文字',
      args: [],
    );
  }

  /// `沒有資料`
  String get common_message_no_data {
    return Intl.message(
      '沒有資料',
      name: 'common_message_no_data',
      desc: '通用的沒有資料提示文字',
      args: [],
    );
  }

  /// `沒有網路連線`
  String get common_message_no_internet {
    return Intl.message(
      '沒有網路連線',
      name: 'common_message_no_internet',
      desc: '通用的沒有網路連線提示文字',
      args: [],
    );
  }

  /// `發生錯誤`
  String get common_message_has_error {
    return Intl.message(
      '發生錯誤',
      name: 'common_message_has_error',
      desc: '通用的錯誤訊息提示文字',
      args: [],
    );
  }

  /// `確認`
  String get common_message_confirm {
    return Intl.message(
      '確認',
      name: 'common_message_confirm',
      desc: '通用的確認按鈕文字',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
