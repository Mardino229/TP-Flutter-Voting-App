
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_instance.dart';

class AuthentificateService {

  Dio api = configureDio();

  Future<Map<String, dynamic>> register (Map<String, dynamic> data) async{

    final response = await api.post('register', data: data);
    print("Réponse brute : ${response.data}");

    // Si le statut est 422 (erreur de validation), renvoyer une exception avec les détails
    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> login (Map<String, dynamic> data) async{

    final response = await api.post('login', data: data);
    print("Réponse brute : ${response.data}");

    // Si le statut est 422 (erreur de validation), renvoyer une exception avec les détails
    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> sendOtp (Map<String, dynamic> data) async{

    final response = await api.post('password/send-otp', data: data);

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

  Future<Map<String, dynamic>> resetPassword (Map<String, dynamic> data) async{

    final response = await api.post('password/reset', data: data);

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

  Future<Map<String, dynamic>> logout () async{

    final pref = await SharedPreferences.getInstance();
    int? npi = pref.getInt("npi") ?? null;

    // if (npi != "") {}

    print(npi);

    final response = await api.post('logout', data: {"npi": npi});

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

}