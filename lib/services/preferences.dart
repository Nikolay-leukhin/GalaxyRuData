import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:galaxy_rudata/services/api/service/token_model.dart';

class PreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final String _tokenKey = 'token';
  final String _pinCodeKey = 'pin';
  final String _seedPhraseKey = 'seed';
  final String _emailKey = 'email';
  final String _inviteCodeKey = 'invite_code';
  final String _placeIdKey = 'place_id';

  Future saveToken(Token token) async {
    final prefs = await _prefs;
    await prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  Future<Token> getToken() async {
    final prefs = await _prefs;

    try {
      final Token jwt = Token.fromJson(jsonDecode(prefs.getString(_tokenKey)!));
      return jwt;
    } catch (e, st) {
      print(e);
      print(st);
      return Token.zero();
    }
  }

  Future<void> setPinCode(String pinCode) async {
    final prefs = await _prefs;
    await prefs.setString(_pinCodeKey, pinCode);
  }

  Future<String?> getPinCode() async {
    final prefs = await _prefs;
    return prefs.getString(_pinCodeKey);
  }

  Future<void> setSeedPhrase(String seedPhrase) async {
    final prefs = await _prefs;
    await prefs.setString(_seedPhraseKey, seedPhrase);
  }

  Future<String?> getSeedPhrase() async {
    final prefs = await _prefs;
    return prefs.getString(_seedPhraseKey);
  }

  Future<void> setEmail(String email) async {
    final prefs = await _prefs;
    await prefs.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString(_emailKey);
  }

  Future<void> setInviteCode(String code) async {
    final prefs = await _prefs;
    prefs.setString(_inviteCodeKey, code);
  }
  Future<String?> getInviteCode() async {
    final prefs = await _prefs;
    final code = prefs.getString(_inviteCodeKey);
    return code;
  }
  Future<void> setPlaceId(String code) async {
    final prefs = await _prefs;
    prefs.setString(_placeIdKey, code);
  }
  Future<String?> getPlaceId() async {
    final prefs = await _prefs;
    final code = prefs.getString(_inviteCodeKey);
    return code;
  }

  Future logout() async => _prefs.then((value) => value.clear());
}
