part of '../api_service.dart';

mixin class ApiHandler {
  late final Dio dio;
  late final PreferencesService preferencesService;
  late final Token currentToken;

  Future get(String url,
          {Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? data}) =>
      _handleErrors(
        requestData: RequestData(url, data: data, queryParams: queryParameters),
        method: MethodsEnum.get,
      );

  Future post(String url,
          {Map<String, dynamic>? data,
          Map<String, dynamic>? queryParameters}) =>
      _handleErrors(
          requestData:
              RequestData(url, data: data, queryParams: queryParameters),
          method: MethodsEnum.post);

  Future delete(String url) async =>
      _handleErrors(method: MethodsEnum.delete, requestData: RequestData(url));

  Future<void> refreshToken(Token token) async {
    await preferencesService.saveToken(token);

    currentToken.setJwt(token.jwt);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': currentToken.jwt
    };
  }

  Future _handleErrors(
      {required MethodsEnum method,
      // required String url,
      // Map<String, dynamic>? queryParams,
      // Map<String, dynamic>? data
      required RequestData requestData}) async {
    try {
      Response res;

      res = await _executeMethod(method, requestData);

      if (res.statusCode == 401) throw UnAuthorizedException;

      // if (res.statusCode == 401) {
      //   final newToken = await dio.post(ApiEndpoints.refresh);
      //
      //   // await refreshToken(newToken.data['jwt']);
      //
      //   res = await _executeMethod(
      //       method, RequestData(url, queryParams: queryParams, data: data));
      // }

      return res.data;
    } catch (e) {
      log('error by calling ${requestData.url}');
      rethrow;
    }
  }

  /// не трогать используется только внутри [_handleErrors]
  Future<Response<dynamic>> _executeMethod(
          MethodsEnum method, RequestData requestData) =>
      dio.request(requestData.url,
          options: Options(method: methods[method]!),
          queryParameters: requestData.queryParams,
          data: requestData.data);
}
