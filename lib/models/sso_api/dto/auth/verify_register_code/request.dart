/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:11:02
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-26 15:30:01
 * @Description: 
 */

class VerifyRegisterCodeRequest {
  final String account;
  final String code;

  VerifyRegisterCodeRequest({
    required this.account,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
        'code': code,
      };
}
