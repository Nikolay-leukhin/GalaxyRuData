class ApiEndpoints {
  static const refresh = '';

  static const authVerifyCode = '/v1/auth/verify';
  static const authSendEmailCode = "/v1/auth/login";

  static const useLandCode = '/v1/invite-codes/use';
  static const connectCodeAndLand = '/v1/invite-codes/connect-land';
  static const verifyLandCode = '/v1/invite-codes/verify';

  static const freeLands = '/v1/lands/free';

  static const user = '/v1/user/self';
  static const userWalletUpdate = '/v1/user/update/wallet';
}
