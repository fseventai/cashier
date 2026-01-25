import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:5173/api',
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
