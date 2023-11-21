part of 'api_service.dart';

class Wallet with ApiHandler {
  Wallet({required ServiceData apiServiceData}) {
    serviceData = apiServiceData;
  }

  Future<void> updateWalletAddress(String walletAddress) =>
      post(ApiEndpoints.userWalletUpdate, data: {'wallet': walletAddress});
}
