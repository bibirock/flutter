/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 15:46:07
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 15:52:05
 * @Description: 
 */

import 'package:flutter/material.dart';
import '/generated/l10n.dart';

class ErrorDialog {
  /// 顯示錯誤對話框
  ///
  /// [context] - 當前的建構內容
  /// [title] - 對話框標題
  /// [errorMessage] - 錯誤訊息內容
  /// [buttonText] - 確認按鈕文字
  static void show({
    required BuildContext context,
    required String errorMessage,
  }) {
    final l10n = S.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.common_message_has_error),
          content:
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.common_message_confirm),
            ),
          ],
        );
      },
    );
  }
}
