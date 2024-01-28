part of '../../api_service.dart';

class RequestData {
  RequestData(this.url, {this.queryParams, this.data, this.customExceptionHandler});

  final String url;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? data;
  final VoidCallback? customExceptionHandler;

  @override
  String toString() => '$url\nquery: $queryParams\ndata: $data';
}
