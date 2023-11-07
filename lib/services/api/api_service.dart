import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:starter/models/user.dart';
import 'package:starter/services/api/endpoints.dart';
import 'package:starter/services/api/token_model.dart';
import 'package:starter/services/preferences.dart';

part 'handler.dart';
part 'auth.dart';


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
  final PreferencesService preferencesService;
  final Dio dio = Dio(_dioOptions)..interceptors.add(PrettyDioLogger());

  late final Token token;
  late final Auth auth;

  ApiService({required this.preferencesService}) {
    initialServices();
  }

  void initialServices() async {
    token = await preferencesService.getToken();

    log(token.accessToken.toString());

    auth = Auth(dio_: dio, preferences: preferencesService, token: token);

    auth.refreshToken(token);
  }

  Future<void> logout() async {
    await preferencesService.logout();
    auth.refreshToken(Token.zero());
  }
}