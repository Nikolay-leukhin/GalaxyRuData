import 'package:galaxy_rudata/utils/clusters.dart';

class LandModel {
  int id;
  String clusterName;
  String? description;
  String avatar;
  bool isMinted;
  int? tokenId;
  String? code;
  String type;

  LandModel({
    required this.id,
    required this.clusterName,
    required this.description,
    required this.avatar,
    required this.isMinted,
    required this.tokenId,
    required this.type, required this.code,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
      id: json['id'] as int,
      clusterName: clusters[json['cluster']]!.name,
      code: json['name'],
      description: json['description'],
      avatar: "https://roskadastr.danya-vecher.ru/photo/",
      isMinted: json['isMinted'] as bool,
      tokenId: json['tokenId'] as int?,
      type: json['cluster'] as String,
    );
  }

  @override
  String toString() {
    return 'LandModel{id: $id, name: $clusterName, description: $description, avatar: $avatar, isMinted: $isMinted, tokenId: $tokenId, type: $type}';
  }
}
