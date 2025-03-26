/*
 * @Author: Joe.Chen
 * @Date: 2025-03-25 14:40:12
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 10:36:11
 * @Description: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingService {
  // 單例模式
  static final LoadingService _instance = LoadingService._internal();
  factory LoadingService() => _instance;
  LoadingService._internal();

  // 使用 ValueNotifier 來通知狀態變化
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // 設置 loading 狀態
  void setLoading(bool value) {
    isLoading.value = value;
  }

  // 使用 loading 狀態包裝異步任務
  Future<T> withLoading<T>(Future<T> Function() asyncTask) async {
    isLoading.value = true;
    try {
      return await asyncTask();
    } finally {
      isLoading.value = false;
    }
  }
}

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void setLoading(bool value) {
    state = value;
  }

  Future<T> withLoading<T>(Future<T> Function() asyncTask) async {
    state = true;
    try {
      return await asyncTask();
    } finally {
      state = false;
    }
  }
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});
