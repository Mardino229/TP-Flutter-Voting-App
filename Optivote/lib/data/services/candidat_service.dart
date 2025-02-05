import 'dart:io';

import 'package:dio/dio.dart';
import 'package:optivote/data/models/candidat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_instance.dart';

class CandidatService {

  Dio api = configureDio();

  Future<Map<String, dynamic>> add (
     Map<String, dynamic> data,
    File? imageFile,
  ) async {

      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("token") ?? "";

      if (token != "") {
        api.options.headers['AUTHORIZATION'] = 'Bearer $token';
      }

      final formData = FormData.fromMap({
        ...data,
        if (imageFile != null)
          "photo": await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });

      final response = await api.post('candidat', data: formData);

      if (response.statusCode == 422) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
  }

  Future<Map<String, dynamic>> delete (int id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.delete('candidat/$id');

    return response.data;
  }

  Future<List<Candidat>> getAll (String election_id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('candidats/$election_id');

    return (response.data["body"] as List).map((e) => Candidat.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> get (int id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('candidat/$id');

    return response.data;
  }

  Future<Map<String, dynamic>> update (int id, {
    required Map<String, dynamic> data,
    File? imageFile,
  }) async {
    final formData = FormData.fromMap({
      ...data,
      if (imageFile != null)
        "photo": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await api.put('candidat/$id', data: formData);

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