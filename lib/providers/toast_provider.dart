/*
 * @Author: Joe.Chen
 * @Date: 2025-03-25 17:36:10
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 10:50:16
 * @Description: 提供 Toast 功能的小部件
 */

import 'package:flutter/material.dart';
import '/widgets/toast.dart';

class ToastProvider extends StatefulWidget {
  final Widget child;

  const ToastProvider({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _ToastProviderState createState() => _ToastProviderState();
}

class _ToastProviderState extends State<ToastProvider> {
  @override
  void initState() {
    super.initState();

    // 使用 Post-Frame Callback 確保 Overlay 已經建立
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ToastUtil.init(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
