import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DioNetwork {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _getBaseUrl(),
    ));
    return dio;
  }

  static String _getBaseUrl() {
    final baseUrl = dotenv.env['BASE_URL'];
    final basePath = dotenv.env['BASE_PATH'];
    return (baseUrl ?? 'https://api.example.com') + (basePath ?? '');
  }
}
