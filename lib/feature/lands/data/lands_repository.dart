import 'dart:math';

import 'package:galaxy_rudata/models/land.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:galaxy_rudata/utils/clusters.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class LandsRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  String? code;

  /// снести потом
  String? approve;

  List<LandModel> freeLandsList = [];
  List<String> availableClustersNames = [];
  List<LandModel> userLandsList = [];

  BehaviorSubject<LoadingStateEnum> freeLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);
  BehaviorSubject<LoadingStateEnum> userLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  LandsRepository({required this.apiService, required this.prefs});

  Future<void> useInviteCode(String usedCode) async {
    await apiService.land.useInviteCode(usedCode);
    code = usedCode;
  }

  Future<void> connectLandToCurrentCode(int landId) async {
    await apiService.land.connectLandAndCode(code: code!, landId: landId);
  }

  Future<void> connectRandomFromClusterLandToCurrentCode(String clusterType) async {
    List<LandModel> lands = [];
    for (var i in freeLandsList) {
      if (i.type == clusterType) {
        lands.add(i);
      }
    }
    final random =  Random();

    final land = lands[random.nextInt(lands.length)];
    await connectLandToCurrentCode(land.id);
  }

  Future getApprove() async {
    final res = await apiService.land.getApprove(code!);
    approve = res['data'];
  }

  Future<void> verifyInviteCode(String approveCode) async {
    await apiService.land.verifyLandCode(code!, approveCode);
  }

  Future<void> loadFreeLands() async {
    freeLandsStream.add(LoadingStateEnum.loading);
    try {
      final response = (await apiService.land.getFreeLands())['lands'];
      freeLandsList.clear();
      for (var json in response) {
        freeLandsList.add(LandModel.fromJson(json));
        try {
          if (!availableClustersNames.contains(json['type'])) {
            availableClustersNames.add(json['type']);
          }
        } catch (e) {}
      }
      freeLandsStream.add(LoadingStateEnum.success);
    } catch (e, st) {
      print(e);
      print(st);
      freeLandsStream.add(LoadingStateEnum.fail);
    }
  }

  Future loadUserLands() async {
    userLandsStream.add(LoadingStateEnum.loading);

    try {
      final response = (await apiService.land.getUserLands())['lands'];
      userLandsList.clear();
      for (var json in response) {
        userLandsList.add(LandModel.fromJson(json));
      }
      userLandsStream.add(LoadingStateEnum.success);
    } catch (e, st) {
      print(e);
      print(st);
      userLandsStream.add(LoadingStateEnum.fail);
    }
  }
}
