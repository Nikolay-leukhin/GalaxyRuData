class ApiEndpoints {
  static const refresh = '';

  static const authVerifyCode = '/v1/auth/verify';
  static const authSendEmailCode = "/v1/auth/login";

  static const useCode = '/v1/invite-codes/use';
  static const connectCodeAndLand = '/v1/invite-codes/connect-land';
  static const verifyLandCode = '/v1/invite-codes/verify';

  static const walletUpdateAddress = '/v1/user/update/wallet';

  static const landUseInviteCode = '/v1/invite-codes/use';
}
