/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:11:02
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 18:42:52
 * @Description: 
 */

class VerifyPasswordRequest {
  final String account;
  final String code;

  VerifyPasswordRequest({
    required this.account,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
        'code': code,
      };
}
