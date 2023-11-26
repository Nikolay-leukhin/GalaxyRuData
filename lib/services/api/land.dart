part of 'api_service.dart';

class Land with ApiHandler {
  Land({required ServiceData apiServiceData}) {
    serviceData = apiServiceData;
  }

  Future<void> updateWalletAddress(String walletAddress) =>
      post(ApiEndpoints.userWalletUpdate, data: {'Land': walletAddress});

  Future<void> useInviteCode(String code) =>
      post(ApiEndpoints.useLandCode, data: {'code': code});

  Future<Map<String, dynamic>> getFreeLands() async {
    return await post(ApiEndpoints.freeLands);
  }

  Future<Map<String, dynamic>> getUserLands() async {
    return await post(ApiEndpoints.userLands);
  }

  Future connectLandAndCode({required String code, required int landId}) =>
      post(ApiEndpoints.connectCodeAndLand,
          data: {"code": code, "landId": landId});

  Future getApprove(String code) =>
      post(ApiEndpoints.getApprove, data: {'code': code});

  Future<void> verifyLandCode(String code, String approveCode) =>
      post(ApiEndpoints.verifyLandCode,
          data: {'code': code, 'approve': approveCode});
}
