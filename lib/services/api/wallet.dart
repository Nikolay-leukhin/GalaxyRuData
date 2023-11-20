part of 'api_service.dart';

class Wallet with ApiHandler {
  Wallet(
      {required Dio dio_,
      required PreferencesService preferences,
        required BehaviorSubject apiExceptions,
      required Token token}) {
    preferencesService = preferences;
    dio = dio_;
    exceptionsStream = apiExceptions;
    currentToken = token;
  }

  Future<void> updateWalletAddress(String walletAddress) async {
    print(currentToken.jwt);
    await post(ApiEndpoints.userWalletUpdate, data: {'wallet': walletAddress});
  }
}
