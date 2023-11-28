part of '../api_service.dart';

const baseUrl = 'BASE_SERVER_URL';
const betaUrl = 'BETA_SERVER_URL';

const Map<String, dynamic> defaultHeaders = {
  'Content-Type': 'application/json',
};

BaseOptions defaultDioOptions = BaseOptions(
  baseUrl: dotenv.get(baseUrl),
  headers: defaultHeaders,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 20),
  sendTimeout: const Duration(seconds: 15),
);
