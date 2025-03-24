/*
 * @Author: Joe.Chen
 * @Date: 2025-03-24 17:02:03
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-24 17:16:08
 * @Description: 
 */
class SendResetCodeRequest {
  final String account;

  SendResetCodeRequest({
    required this.account,
  });

  Map<String, dynamic> toJson() => {
        'account': account,
      };
}
