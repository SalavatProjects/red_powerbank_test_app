import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioNetwork {
  Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _getBaseUrl(),
    ));
    return dio;
  }

  String _getBaseUrl() {
    final baseUrl = dotenv.env['BASE_URL'];
    final basePath = dotenv.env['BASE_PATH'];
    return (baseUrl ?? 'https://api.example.com') + (basePath ?? '');
  }
}
