class Token {
  String accessToken;
  String refreshToken;

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['access'],
        refreshToken = json['refresh'];

  Token.zero()
      : refreshToken = '',
        accessToken = '';

  Map<String, String> toJson() =>
      {'access': accessToken, 'refresh': refreshToken};

  void copy(Token token) {
    accessToken = token.accessToken;
    refreshToken = token.refreshToken;
  }
}
