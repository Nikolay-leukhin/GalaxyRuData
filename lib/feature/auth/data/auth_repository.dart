import 'package:rxdart/rxdart.dart';
import 'package:starter/models/user.dart';
import 'package:starter/services/api/api_service.dart';
import 'package:starter/utils/utils.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> authState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject.seeded(AppStateEnum.wait);

  User? user;

  void login(String email, String password) async {
    authState.add(LoadingStateEnum.loading);
    try {
      user = await _apiService.auth.login(email, password);
      authState.add(LoadingStateEnum.success);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      authState.add(LoadingStateEnum.fail);
    }
  }

  void register(String name, String email, String password) async {
    authState.add(LoadingStateEnum.loading);
    try {
      user = await _apiService.auth
          .register(name: name, password: password, email: email);
      authState.add(LoadingStateEnum.success);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      authState.add(LoadingStateEnum.fail);
    }
  }

  void logout() => _apiService.logout();
}
