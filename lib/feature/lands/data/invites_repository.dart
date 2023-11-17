import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';

class InvitesRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  InvitesRepository({required this.apiService, required this.prefs});

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
