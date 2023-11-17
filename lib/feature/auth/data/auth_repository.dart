import 'package:galaxy_rudata/services/preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:galaxy_rudata/models/user.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class AuthRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  AuthRepository({required this.apiService, required this.prefs}) {
    checkUserAuth();
  }

  BehaviorSubject<LoadingStateEnum> authState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject.seeded(AppStateEnum.wait);

  List<int> typedUserPinCode = [];

  Future<void> checkUserAuth() async {
    final token = await prefs.getToken();
    if (token.jwt == "") {
      appState.add(AppStateEnum.unAuth);
    } else {
      appState.add(AppStateEnum.auth);
    }
  }

  void auth(String email, String code) async {
    authState.add(LoadingStateEnum.loading);
    try {
      await apiService.auth.verifyCode(email, code);

      authState.add(LoadingStateEnum.success);
      appState.add(AppStateEnum.auth);
    } catch (e, st) {
      print(e);
      print(st);
      authState.add(LoadingStateEnum.fail);
    }
  }

  Future<void> logout() async {
    await apiService.logout();
    appState.add(AppStateEnum.unAuth);
  }

  Future<void> savePinCode() async {
    await prefs.setPinCode(typedUserPinCode.join(""));
  }

  Future<String?> getPinCode() async {
    return await prefs.getPinCode();
  }

  Future<void> sendEmailCode(String email) async {
    await apiService.auth.sendCode(email);
  }
}
