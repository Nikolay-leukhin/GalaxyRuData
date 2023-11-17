part of 'api_service.dart';

class Wallet with ApiHandler {
  Wallet(
      {required Dio dio_,
      required PreferencesService preferences,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    currentToken = token;
  }

  Future<void> updateWalletAddress(String walletAddress) async {
    await post(ApiEndpoints.walletUpdateAddress,
        data: {'wallet': walletAddress});
  }
}
