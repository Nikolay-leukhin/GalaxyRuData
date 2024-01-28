part of 'api_service.dart';

class Land with ApiHandler {
  Land(ServiceData apiServiceData) {
    serviceData = apiServiceData;
  }

  Future<void> updateWalletAddress(String walletAddress) =>
      post(ApiEndpoints.userWalletUpdate, data: {'Land': walletAddress});

  Future useInviteCode(String code) =>
      post(ApiEndpoints.useLandCode, data: {'code': code}, handler: (e) {
        if (e.response?.data['error'] == 'Not owner.') {
          throw CodeWasUsedException();
        } else if (e.response?.data['error'] == 'Invalid code.') {
          throw InvalidCodeException();
        }
      });

  Future<Map<String, dynamic>> getFreeLands() async {
    return await post(ApiEndpoints.freeLands);
  }

  Future<Map<String, dynamic>> getUserLands() async {
    return await post(ApiEndpoints.userLands);
  }

  Future connectLandAndCode({required String code, required String cluster}) =>
      post(ApiEndpoints.connectCodeAndLand,
          data: {"code": code, "cluster": cluster});

  Future getApprove(String code) =>
      post(ApiEndpoints.getApprove, data: {'code': code});

  Future<void> verifyLandCode(String code, String approveCode) =>
      post(ApiEndpoints.verifyLandCode,
          data: {'code': code, 'approve': approveCode}, handler: (e) {
        if (e.response?.data['error'] == 'Error approve.') {
          throw InvalidCodeException();
        }
      });
}
