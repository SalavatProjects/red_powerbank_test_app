import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioNetwork {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _getBaseUrl(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ))..interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            responseBody: true,
            requestBody: true));
    return dio;
  }

  static String _getBaseUrl() {
    final String baseUrl = dotenv.get('BASE_URL');
    final String basePath = dotenv.get('BASE_PATH');
    return baseUrl + basePath;
  }
}
