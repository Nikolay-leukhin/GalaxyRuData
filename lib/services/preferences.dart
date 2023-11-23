import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:galaxy_rudata/services/api/service/models/token_model.dart';

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
    final String? jwt = prefs.getString(_tokenKey);
    if (jwt == null) return Token.zero();
    final Token token = Token.fromJson(jsonDecode(jwt));
    return token;
  }

  Future<void> setPinCode(String pinCode) async {
    final prefs = await _prefs;
    await prefs.setString(_pinCodeKey, pinCode);
  }

  Future<String?> getPinCode() async {
    final prefs = await _prefs;
    return prefs.getString(_pinCodeKey);
  }

  Future<void> setSeedPhrase(
      {required String seedPhrase, required String email}) async {
    final prefs = await _prefs;

    Map<String, dynamic> seedStorage = await getSeedPhrase() ?? {};
    seedStorage[email] = seedPhrase;

    String encodedSeed = jsonEncode(seedStorage);

    await prefs.setString(_seedPhraseKey, encodedSeed);
  }

  Future<Map<String, dynamic>?> getSeedPhrase() async {
    final prefs = await _prefs;
    final String? encodedSeedStorage = prefs.getString(_seedPhraseKey);
    if (encodedSeedStorage == null) {
      return null;
    }

    Map<String, dynamic> seedStorage = jsonDecode(encodedSeedStorage);
    return seedStorage;
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

  Future logout() async {
    final prefs = await _prefs;

    await prefs.remove(_emailKey);
    await prefs.remove(_pinCodeKey);
    await prefs.remove(_inviteCodeKey);
    await prefs.remove(_placeIdKey);
    await prefs.remove(_tokenKey);
  }
}
