import 'dart:developer';

import 'package:galaxy_rudata/services/preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class AuthRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  String? currentEmail;

  AuthRepository({required this.apiService, required this.prefs}) {
    checkUserAuth();
    apiService.apiExceptions.stream.listen((event) {
      print(event);
      if (event is UnAuthorizedException) logout();
    });
  }

  BehaviorSubject<LoadingStateEnum> authState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject.seeded(AppStateEnum.wait);

  List<int> typedUserPinCode = [];

  Future<void> checkUserAuth() async {
    final token = await prefs.getToken();
    await Future.delayed(Duration(seconds: 5));

    if (token.jwt.isEmpty) {
      appState.add(AppStateEnum.unAuth);
    } else {
      currentEmail = await prefs.getEmail();

      appState.add(AppStateEnum.auth);
    }
  }

  void auth(String email, String code) async {
    authState.add(LoadingStateEnum.loading);
    try {
      await apiService.auth.verifyCode(email, code);
      prefs.setEmail(email);
      currentEmail = email;

      authState.add(LoadingStateEnum.success);
      appState.add(AppStateEnum.auth);
    } catch (e, st) {
      print(e);
      print(st);
      authState.add(LoadingStateEnum.fail);
    }
  }

  void logout() {
    apiService.logout();
    appState.add(AppStateEnum.unAuth);
  }

  Future<void> savePinCode() async {
    await prefs.setPinCode(typedUserPinCode.join(""));
    appState.add(AppStateEnum.auth);
  }

  Future<String?> getPinCode() async {
    return await prefs.getPinCode();
  }

  Future<void> sendEmailCode(String email) async {
    await apiService.auth.sendCode(email);
  }

  Future<InviteCode?> currentInviteCode() async {
    await apiService.initialized;

    final res = await apiService.auth.getUser();
    for (var i in res['user']['inviteCodes']) {
      if (i['isClaimed'] == false) {
        return InviteCode(
            code: i['code'], isClaimed: false, forLandId: i['forLandId']);
      }
    }
    return null;
  }
}

class InviteCode {
  final String code;
  final int? forLandId;
  final bool isClaimed;

  InviteCode({required this.code, required this.isClaimed, this.forLandId});
}
