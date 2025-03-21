/*
 * @Author: Joe.Chen
 * @Date: 2025-03-20 16:05:15
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-21 17:54:03
 * @Description: 
 */

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';

class ApiService {
  static final Map<String, ApiService> _cache = {};
  late Dio dio;

  factory ApiService(String baseUrl) {
    if (_cache.containsKey(baseUrl)) {
      return _cache[baseUrl]!;
    } else {
      final apiService = ApiService._internal(baseUrl);
      _cache[baseUrl] = apiService;
      return apiService;
    }
  }

  ApiService._internal(String baseUrl) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status! < 500,
    ));

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      retries: 3,
      logPrint: (String message) {
        debugPrint('retry: $message');
      },
      toNoInternetPageNavigator: () async {
        //TODO: Handle no internet connection scenario
        return;
      },
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 預留 token 處理 (需補充 token 來源)
          // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // 預留 token 失效處理邏輯
          }
          return handler.next(error);
        },
      ),
    );
  }

  void updateBaseUrl(String newUrl) {
    dio.options.baseUrl = newUrl;
  }

  void updateRequestHeader(String key, String value) {
    dio.options.headers[key] = value;
  }
}
