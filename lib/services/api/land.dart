part of 'api_service.dart';

class Land with ApiHandler {
  Land(
      {required Dio dio_,
      required PreferencesService preferences,
        required BehaviorSubject apiExceptions,
      required Token token}) {
    preferencesService = preferences;
    exceptionsStream = apiExceptions;
    dio = dio_;
    currentToken = token;
  }

  Future<void> updateWalletAddress(String walletAddress) async {
    await post(ApiEndpoints.userWalletUpdate, data: {'Land': walletAddress});
  }

  Future<void> useInviteCode(String code) async {
    await post(ApiEndpoints.useLandCode, data: {'code': code});
  }

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

  Future<void> verifyLandCode(String code, String approveCode) async {
    await post(ApiEndpoints.verifyLandCode,
        data: {'code': code, 'approve': approveCode});
  }
}
