part of '../api_service.dart';

mixin class ApiHandler {
  late final ServiceData serviceData;

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
    await serviceData.prefs.saveToken(token);
    serviceData.token.setJwt(token.jwt);

    log('token refreshed on ${serviceData.token}');
    log("________________________");

    serviceData.dio.options.headers = _getHeadersWithCurrentToken();
    serviceData.prefs.getToken();
  }

  // -----------------------------------------------------------------

  Map<String, dynamic> _getHeadersWithCurrentToken() {
    final Map<String, dynamic> newHeaders = Map.from(defaultHeaders);
    newHeaders['Authorization'] = serviceData.token.bearer;
    return newHeaders;
  }

  Future _handleErrors(
      {required MethodsEnum method, required RequestData requestData}) async {
    try {
      Response res;
      res = await _executeMethod(method, requestData);

      return res.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        serviceData.exceptionsStream.add(UnAuthorizedException());
      } else if (e.response?.statusCode == 400 &&
          e.response?.data['error'] == 'User not found.' &&
          requestData.url == ApiEndpoints.user) {
        serviceData.exceptionsStream.add(UnAuthorizedException());
      } else if (requestData.url == ApiEndpoints.useLandCode &&
          e.response?.data['error'] == 'Not owner.') {
        throw CodeWasUsedException();
      } else if (requestData.url == ApiEndpoints.useLandCode &&
          e.response?.data['error'] == 'Invalid code.') {
        throw InvalidCodeException();
      } else if (requestData.url == ApiEndpoints.verifyLandCode &&
          e.response?.data['error'] == 'Error approve.') {
        throw InvalidCodeException();
      } else {
        log('headers: ${serviceData.dio.options.headers}');
        log('error by calling ${requestData.url}');
        log(requestData.toString());
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// не трогать используется только внутри [_handleErrors]
  Future<Response<dynamic>> _executeMethod(
      MethodsEnum method, RequestData requestData) async {
    await serviceData.requiredFuture;
    return serviceData.dio.request(requestData.url,
        options: Options(method: methods[method]!),
        queryParameters: requestData.queryParams,
        data: requestData.data);
  }
}
