import 'package:galaxy_rudata/models/land.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

enum CodeStates { lock, choose, quests }

class LandsRepository {
  final ApiService _apiService;
  String? code;

  /// снести потом
  String? approve;

  List<LandModel> userLandsList = [];

  BehaviorSubject<LoadingStateEnum> userLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<CodeStates> codeStates = BehaviorSubject();

  LandsRepository(
      {required ApiService apiService})
      :
        _apiService = apiService;

  Future<void> useInviteCode(
      String usedCode) async {
    await _apiService.land.useInviteCode(usedCode);
    code = usedCode;
  }

  void codeUsed() =>
    codeStates.add(CodeStates.choose);


  Future<void> connectLandFromClusterToCurrentCode(String cluster) async {
    await _apiService.land.connectLandAndCode(code: code!, cluster: cluster);
    codeStates.add(CodeStates.quests);
  }

  Future getApprove() async {
    final res = await _apiService.land.getApprove(code!);
    approve = res['data'];
  }

  Future<void> verifyInviteCode(String approveCode) async {
    await _apiService.land.verifyLandCode(code!, approveCode);
  }

  Future loadUserLands() async {
    userLandsStream.add(LoadingStateEnum.loading);

    try {
      final response = (await _apiService.land.getUserLands())['lands'];
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
