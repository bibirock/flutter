/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:11:02
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-25 17:01:18
 * @Description: 
 */

class VerifyResetCodeRequest {
  final String account;
  final String code;

  VerifyResetCodeRequest({
    required this.account,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
        'code': code,
      };
}
