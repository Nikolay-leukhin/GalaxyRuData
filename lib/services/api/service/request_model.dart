part of '../api_service.dart';

class RequestData {
  RequestData(this.url, {this.queryParams, this.data});

  final String url;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? data;
}