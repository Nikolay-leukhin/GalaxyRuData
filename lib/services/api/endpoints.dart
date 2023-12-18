class ApiEndpoints {
  static const _version = '/v1';

  static const _auth = '$_version/auth';
  static const _invites = '$_version/invite-codes';
  static const _lands = '$_version/lands';
  static const _user = '$_version/user';
  static const _appSettings = '$_version/app-settings';

  // ---------------------------------------

  static const refresh = '';

  static const appVersion = '$_appSettings/app-version';

  static const authVerifyCode = '$_auth/verify';
  static const authSendEmailCode = "$_auth/login";

  static const useLandCode = '$_invites/use';
  static const connectCodeAndLand = '$_invites/connect-land';
  static const getApprove = '$_invites/get-approve';
  static const verifyLandCode = '$_invites/verify';

  static const freeLands = '$_lands/free';
  static const userLands = '$_lands/owner';

  static const user = '$_user/self';
  static const userWalletUpdate = '$_user/update/wallet';
  static const notifications = '$_user/notifications';
  static const readNotification = '$_user/notifications/read';
}
