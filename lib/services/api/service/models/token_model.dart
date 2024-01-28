class Token {
  String jwt;

  Token({required this.jwt});

  void setJwt(String newJwt) => jwt = newJwt;

  Token.fromJson(Map<String, dynamic> json) : jwt = json['jwt'];

  Token.zero() : jwt = "";

  Map<String, String> toJson() => {'jwt': jwt};

  String get bearer => 'Bearer $jwt';

  @override
  String toString() => 'JWT Token $jwt';
}
