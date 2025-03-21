import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this._prefs) : super(_prefs.containsKey('accessToken'));

  final SharedPreferences _prefs;

  void signIn(String accessToken, String accountId) {
    _prefs.setString('accessToken', accessToken);
    _prefs.setString('accountId', accountId);
    state = true;
  }

  void signOut() {
    _prefs.remove('accessToken');
    _prefs.remove('accountId');
    state = false;
  }

  String? getAccountId() {
    return _prefs.getString('accountId');
  }

  String? getAccessToken() {
    return _prefs.getString('accessToken');
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('必須在 main.dart 中覆寫此 provider');
});

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthNotifier(prefs);
});
