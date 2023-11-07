part of 'api_service.dart';

enum Methods { get, post, delete }

mixin class ApiHandler {
  late final Dio dio;
  late final PreferencesService preferencesService;
  late final Token currentToken;

  _errorHandler(
      {required Methods method,
      required String url,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data}) async {
    try {
      Response res;

      if (method == Methods.get) {
        res = await dio.get(url, queryParameters: queryParams, data: data);
      } else if (method == Methods.post) {
        res = await dio.post(url, queryParameters: queryParams, data: data);
      } else {
        res = await dio.delete(url, data: data, queryParameters: queryParams);
      }

      if (res.statusCode == 401) {
        final newToken = await dio.post(ApiEndpoints.refresh);

        await refreshToken(newToken.data['jwt']);

        if (method == Methods.get) {
          res = await dio.get(url, queryParameters: queryParams, data: data);
        } else if (method == Methods.post) {
          res = await dio.post(url, queryParameters: queryParams, data: data);
        } else {
          res = await dio.delete(url, data: data, queryParameters: queryParams);
        }
      }

      return res.data;
    } catch (e) {
      log(url);
      rethrow;
    }
  }

  Future get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data}) async {
    return _errorHandler(
        url: url,
        queryParams: queryParameters,
        method: Methods.get,
        data: data);
  }

  Future post(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return _errorHandler(
        url: url,
        data: data,
        queryParams: queryParameters,
        method: Methods.post);
  }

  Future delete(String url) async {
    try {
      final res = await dio.delete(url);
      return res.data;
    } catch (e) {
      log(url);
      rethrow;
    }
  }

  Future<void> refreshToken(Token token) async {
    await preferencesService.saveToken(token);

    currentToken.copy(token);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': currentToken.accessToken
    };
  }
}
