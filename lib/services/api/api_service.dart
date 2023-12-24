import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/api/service/models/service_data.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:galaxy_rudata/services/api/endpoints.dart';
import 'package:galaxy_rudata/services/api/service/models/token_model.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:rxdart/rxdart.dart';

part 'service/handler.dart';

part 'service/methods.dart';

part 'service/constants.dart';

part 'service/models/request_model.dart';

part 'auth.dart';

part 'wallet.dart';

part 'land.dart';

class ApiService {
  late final ServiceData _apiData;

  late Future initialized;
  BehaviorSubject<Exception> apiExceptions = BehaviorSubject();

  /// При добавлении новых сервисов необходимо инциализировать их в [_initialServices]
  late final Auth auth;
  late final Wallet wallet;
  late final Land land;

  ApiService({required PreferencesService preferencesService}) {
    initialized = _init(preferencesService);
  }

  void logout() {
    _apiData.prefs.logout();
    _apiData.token.setJwt('');
    _apiData.dio.options.headers = defaultHeaders;
  }

  Future _initialServices() async {
    auth = Auth(_apiData);
    wallet = Wallet(_apiData);
    land = Land(_apiData);
  }

  // -----------------------------------------------------

  Future _init(PreferencesService preferencesService) async {
    await _initializeServiceData(preferencesService);
    await _initialServices();
    await auth.refreshToken(_apiData.token);
  }

  /// Инициализирует классы, необходимые для работы по типу [Dio], [PreferencesService]
  Future _initializeServiceData(PreferencesService preferencesService) async {
    final token = await preferencesService.getToken();
    final dio = Dio(defaultDioOptions)..interceptors.add(PrettyDioLogger());
    _apiData = ServiceData(token, dio, preferencesService, apiExceptions);
    _apiData.requiredFuture = initialized;

    log(token.toString());
  }
}
