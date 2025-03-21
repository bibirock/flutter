// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_TW';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "login_screen_button": MessageLookupByLibrary.simpleMessage("登入"),
    "login_screen_enter_account": MessageLookupByLibrary.simpleMessage("請輸入帳號"),
    "login_screen_enter_password": MessageLookupByLibrary.simpleMessage(
      "請輸入密碼",
    ),
    "login_screen_error": MessageLookupByLibrary.simpleMessage("登入失敗"),
    "login_screen_forgot_password": MessageLookupByLibrary.simpleMessage(
      "忘記密碼",
    ),
    "login_screen_no_account": MessageLookupByLibrary.simpleMessage("還沒有帳號嗎"),
    "login_screen_password": MessageLookupByLibrary.simpleMessage("密碼"),
    "login_screen_register": MessageLookupByLibrary.simpleMessage("註冊"),
    "login_screen_username": MessageLookupByLibrary.simpleMessage("使用者名稱"),
  };
}
