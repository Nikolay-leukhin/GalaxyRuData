import 'package:galaxy_rudata/models/land.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
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

  BehaviorSubject<LoadingStateEnum> userLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  LandsRepository({required this.apiService, required this.prefs});

  Future<void> useInviteCode(String usedCode) async {
    await apiService.land.useInviteCode(usedCode);
    code = usedCode;
  }

  Future<void> connectLandFromClusterToCurrentCode(String cluster) async {
    await apiService.land.connectLandAndCode(code: code!, cluster: cluster);
  }

  Future getApprove() async {
    final res = await apiService.land.getApprove(code!);
    approve = res['data'];
  }

  Future<void> verifyInviteCode(String approveCode) async {
    await apiService.land.verifyLandCode(code!, approveCode);
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
