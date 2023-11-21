import 'package:dio/dio.dart';
import 'package:galaxy_rudata/services/api/service/models/token_model.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:rxdart/rxdart.dart';

class ServiceData {
  final Token token;
  final Dio dio;
  final PreferencesService prefs;
  final BehaviorSubject exceptionsStream;
  Future? requiredFuture;

  ServiceData(this.token, this.dio, this.prefs, this.exceptionsStream);
}