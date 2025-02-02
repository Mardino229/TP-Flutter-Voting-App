import 'package:dio/dio.dart';

Dio configureDio() {

  final options = BaseOptions(
    baseUrl: 'https://optivote.mardino.tech/api/',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    validateStatus: (status) => status != null && status < 500,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  );
  final dio = Dio(options);
  // dio.interceptors.add(LogInterceptor(
  //   requestBody: true,
  //   responseBody: true,
  // ));

  return dio;
}