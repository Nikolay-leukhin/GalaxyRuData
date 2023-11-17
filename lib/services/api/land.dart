part of 'api_service.dart';

class Land with ApiHandler {
  Land(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<void> updateWalletAddress(String walletAddress) async {
    await post(ApiEndpoints.walletUpdateAddress, data: {'Land': walletAddress});
  }

  Future<void> useInviteCode(String code) async {
    await post(ApiEndpoints.landUseInviteCode, data: {'code': code});
  }
}
