/*
 * @Author: Joe.Chen
 * @Date: 2025-03-21 13:32:06
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 13:32:11
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 獲取當前登入的用戶資訊
    final accountId = ref.read(authProvider.notifier).getAccountId();

    return Scaffold(
      appBar: AppBar(
        title: const Text('首頁'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 登出
              ref.read(authProvider.notifier).signOut();
              // 不需要手動導航，Riverpod 會監聽狀態變化
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('歡迎，用戶 ID: $accountId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).signOut();
              },
              child: const Text('登出'),
            ),
          ],
        ),
      ),
    );
  }
}
