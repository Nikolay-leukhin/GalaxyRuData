import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/services/api/token_model.dart';

const String _tokenKey = 'token';

class PreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveToken(Token token) async {
    _prefs.then(
        (prefs) => prefs.setString(_tokenKey, jsonEncode(token.toJson())));
  }

  Future<Token> getToken() async {
    final prefs = await _prefs;

    final res = prefs.getString(_tokenKey);
    if (res != null) {
      return Token.fromJson(jsonDecode(res));
    } else {
      return Token.zero();
    }
  }

  Future logout() async =>
      _prefs.then((value) => value.clear());
}
