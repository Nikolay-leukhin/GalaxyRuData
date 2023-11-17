import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class LandsRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  BehaviorSubject<LoadingStateEnum> freeLandsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  LandsRepository({required this.apiService, required this.prefs});

  Future<void> useInviteCode(String code) async {
    await apiService.land.useInviteCode(code);
  }

  Future<void> linkLandByCode() async {
    // nft card dtails
  }

  Future<void> verifyInviteCode() async {
    // сейф
  }

  Future loadFreeLands() async {}

  Future loadUserLands() async {}
}
