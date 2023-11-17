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

  BehaviorSubject<LoadingStateEnum> freeLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  LandsRepository({required this.apiService, required this.prefs});

  Future<void> useInviteCode(String code) async {
    await apiService.land.useInviteCode(code);
  }

  Future<void> linkLandByCode() async {
    // nft card dtails
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
    print("here ------------");

    try {
      final response = (await apiService.land.getFreeLands())['lands'];
      freeLandsList.clear();
      for (var json in response) {
        freeLandsList.add(LandModel.fromJson(json));
      }
      print(freeLandsList);
      freeLandsStream.add(LoadingStateEnum.success);
    } catch (e, st) {
      print(e);
      print(st);
      freeLandsStream.add(LoadingStateEnum.fail);
    }
  }

  Future loadUserLands() async {}
}
