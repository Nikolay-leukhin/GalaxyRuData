part of 'api_service.dart';

class Auth with ApiHandler {
  Auth({required ServiceData apiServiceData}) {
    serviceData = apiServiceData;
  }

  Future<void> verifyCode(String email, String password) async {
    final response = await post(ApiEndpoints.authVerifyCode,
        data: {'email': email, 'time_code': password});

    await refreshToken(Token(jwt: response['jwt']));
  }

  Future<void> sendCode(String email) =>
      post(ApiEndpoints.authSendEmailCode, data: {"email": email});

  Future getUser() => post(ApiEndpoints.user);
}
