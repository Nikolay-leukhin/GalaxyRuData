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

  Future<void> verifyCode(String email, String password) async {
    final response = await post(ApiEndpoints.authVerifyCode,
        data: {'email': email, 'time_code': password});

    refreshToken(Token(jwt: response['jwt']));

    // await preferencesService.saveToken(Token(jwt: response['jwt'],));
  }

  Future<void> sendCode(String email) async {
    await post(ApiEndpoints.authSendEmailCode, data: {"email": email});
  }
}
