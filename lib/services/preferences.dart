import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:galaxy_rudata/services/api/token_model.dart';

class PreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final String _tokenKey = 'token';
  final String _pinCodeKey = 'pin';
  final String _seedPhraseKey = 'seed';

  Future saveToken(Token token) async {
    await _prefs.then(
        (prefs) => prefs.setString(_tokenKey, jsonEncode(token.toJson())));
  }

  Future<Token> getToken() async {
    final prefs = await _prefs;

    try {
      final Token jwt = Token.fromJson(jsonDecode(prefs.getString(_tokenKey)!));
      return jwt;
    } catch (e) {
      return Token.zero();
    }
  }

  Future<void> setPinCode(String pinCode) async {
    final prefs = await _prefs;
    prefs.setString(_pinCodeKey, pinCode);
  }

  Future<String?> getPinCode() async {
    final prefs = await _prefs;
    return prefs.getString(_pinCodeKey);
  }

  Future<void> setSeedPhrase(String seedPhrase) async {
    final prefs = await _prefs;
    prefs.setString(_seedPhraseKey, seedPhrase);
  }

  Future<String?> getSeedPhrase() async {
    final prefs = await _prefs;
    return prefs.getString(_seedPhraseKey);
  }

  Future logout() async => _prefs.then((value) => value.clear());
}
