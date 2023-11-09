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

  User? user;

  List<int> typedUserPinCode = [];

  Future<void> checkUserAuth() async {
    final pinCode = await prefs.getPinCode();
    if (pinCode == null) {
      appState.add(AppStateEnum.unAuth);
    } else {
      appState.add(AppStateEnum.auth);
    }
  }

  void auth(String email, String code) async {
    authState.add(LoadingStateEnum.loading);
    try {
      user = await apiService.auth.auth(email, code);

      await Future.delayed(Duration(seconds: 2));
      authState.add(LoadingStateEnum.success);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      authState.add(LoadingStateEnum.fail);
    }
  }

  void logout() => apiService.logout();

  Future<void> savePinCode() async {
    await prefs.setPinCode(typedUserPinCode.join(""));
  }

  Future<String?> getPinCode() async {
    return await prefs.getPinCode();
  }
}
