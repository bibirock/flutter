/*
 * @Author: Joe.Chen
 * @Date: 2025-03-26 13:04:25
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 13:18:36
 * @Description: 
 */
class ResetPasswordByCodeRequest {
  final String account;
  final String password;
  final String token;

  ResetPasswordByCodeRequest({
    required this.account,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
        'password': password,
        'token': token,
      };
}
