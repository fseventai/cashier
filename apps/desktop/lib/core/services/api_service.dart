import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: '${dotenv.env['API_BASE_URL']}/api',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  // Add interceptors if needed (e.g. for Auth)
}
