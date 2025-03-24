/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:11:02
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:19:45
 * @Description: 
 */

class SignInPasswordRequest {
  static const String application = 'TRACLE-APP';
  final String account;
  final String password;

  SignInPasswordRequest({
    required this.account,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'application': application,
        'account': account,
        'password': password,
      };
}
