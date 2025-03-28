/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 15:46:07
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 10:56:55
 * @Description: 使用 Fluttertoast 實現的提示工具類
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static FToast? _fToast;

  /// 初始化 FToast
  static void init(BuildContext context) {
    // 確保在有 Overlay 的 context 中初始化
    _fToast = FToast().init(context);
  }

  /// 檢查 FToast 是否已初始化
  static bool _ensureInitialized() {
    if (_fToast != null) return true;

    print('錯誤: Toast 尚未初始化，請確保先調用 ToastUtil.init(context)');
    // 使用原生 Toast 顯示錯誤
    Fluttertoast.showToast(
      msg: "Toast 尚未初始化",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    return false;
  }

  /// 顯示錯誤吐司提示
  ///
  /// [errorMessage] - 錯誤訊息內容
  static void showError({
    required String errorMessage,
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    if (!_ensureInitialized()) return;

    Widget toast = _buildToastWithIcon(
      message: errorMessage,
      backgroundColor: Colors.red,
      icon: Icons.error_outline,
    );

    _fToast!.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  /// 顯示一般吐司提示
  ///
  /// [message] - 訊息內容
  static void show({
    required String message,
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.TOP,
    Color backgroundColor = Colors.black54,
    IconData? icon,
  }) {
    if (!_ensureInitialized()) return;

    Widget toast = _buildToastWithIcon(
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
    );

    _fToast!.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  /// 顯示成功吐司提示
  ///
  /// [message] - 訊息內容
  static void showSuccess({
    required String message,
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    if (!_ensureInitialized()) return;

    Widget toast = _buildToastWithIcon(
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
    );

    _fToast!.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  /// 顯示警告吐司提示
  ///
  /// [message] - 訊息內容
  static void showWarning({
    required String message,
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    if (!_ensureInitialized()) return;

    Widget toast = _buildToastWithIcon(
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_amber_outlined,
    );

    _fToast!.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  /// 建立帶圖標的吐司 Widget
  static Widget _buildToastWithIcon({
    required String message,
    required Color backgroundColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12.0),
          ],
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 取消所有排隊中的 Toast
  static void cancelAll() {
    if (_fToast != null) {
      _fToast!.removeQueuedCustomToasts();
    }
  }
}
