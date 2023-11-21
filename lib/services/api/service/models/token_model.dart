class Token {
  String jwt;

  void setJwt(String newJwt) => jwt = newJwt;

  Token({required this.jwt});

  Token.fromJson(Map<String, dynamic> json)
      : jwt = json['jwt'];

  Token.zero()
      : jwt = "";

  Map<String, String> toJson() =>
      {'jwt': jwt};
}
