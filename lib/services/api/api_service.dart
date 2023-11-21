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
part 'service/models/request_model.dart';
part 'auth.dart';
part 'wallet.dart';
part 'land.dart';

const Map<String, dynamic> _authHeaders = {
  'Content-Type': 'application/json',
};

BaseOptions _dioOptions = BaseOptions(
  baseUrl: dotenv.get('BASE_SERVER_URL'),
  headers: _authHeaders,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 20),
  sendTimeout: const Duration(seconds: 15),
);

class ApiService {
  late final ServiceData _apiData;

  BehaviorSubject<Exception> apiExceptions = BehaviorSubject();
  late final Auth auth;
  late final Wallet wallet;
  late final Land land;

  late Future initialized;

  ApiService({required PreferencesService preferencesService})  {
    initialized = initialServices(preferencesService);
  }

  Future initialServices(PreferencesService preferencesService) async {
    final token = await preferencesService.getToken();
    final dio = Dio(_dioOptions)..interceptors.add(PrettyDioLogger());
    _apiData = ServiceData(token, dio, preferencesService, apiExceptions);
    _apiData.requiredFuture = initialized;

    log("JWT Token: ${token.jwt}");

    auth = Auth(apiServiceData: _apiData);
    wallet = Wallet(apiServiceData: _apiData);
    land = Land(apiServiceData: _apiData);

    await auth.refreshToken(token);
  }

  void logout() {
    _apiData.prefs.logout();
    _apiData.token.setJwt('');
    _apiData.dio.options.headers = _authHeaders;
  }
}
