/*
 * @Author: Joe.Chen
 * @Date: 2025-03-26 13:04:25
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 15:07:26
 * @Description: 
 */
class RegisterAccountRequest {
  final String account;
  final String password;
  final String name;
  final String email;

  RegisterAccountRequest({
    required this.account,
    required this.password,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
        'password': password,
        'name': name,
        'email': email,
      };
}
