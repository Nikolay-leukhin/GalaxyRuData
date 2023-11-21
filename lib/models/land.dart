class LandModel {
  int id;
  String name;
  String? description;
  String avatar;
  bool isMinted;
  int? tokenId;
  String type;

  LandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
    required this.isMinted,
    required this.tokenId,
    required this.type,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'],
      avatar: "https://roskadastr.danya-vecher.ru/photo/",
      isMinted: json['isMinted'] as bool,
      tokenId: json['tokenId'] as int?,
      type: json['type'] as String,
    );
  }

  @override
  String toString() {
    return 'LandModel{id: $id, name: $name, description: $description, avatar: $avatar, isMinted: $isMinted, tokenId: $tokenId, type: $type}';
  }
}
