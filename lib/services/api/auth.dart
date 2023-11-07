part of 'api_service.dart';

class Auth with ApiHandler {
  Auth(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<User> login(String email, String password) async {
    return User(name: 'Лох');
  }

  Future<User> register(
      {required String name,
      required String email,
      required String password}) async {
    return User(name: 'Лох');
  }
}
