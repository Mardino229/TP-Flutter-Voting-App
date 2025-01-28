import 'package:dio/dio.dart';
import 'package:optivote/data/models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_instance.dart';

class ElectionService {

  Dio api = configureDio();

  Future<Map<String, dynamic>> create (Map<String, dynamic> data) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.post('elections', data: data);

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

  Future<Map<String, dynamic>> update (int id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.put('elections/$id');

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

  Future<Map<String, dynamic>> delete(int id) async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }
    final response = await api.delete('elections/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> get (int id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('elections/$id');

    return response.data;
  }

  Future<List<Election>> getAll () async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('elections');

    return (response.data.body as List).map((e) => Election.fromJson(e)).toList();
  }

  Future<List<Election>> getAllInProgress () async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('election_inprogress');

    return (response.data.body as List).map((e) => Election.fromJson(e)).toList();
  }

  Future<List<Election>> getAllCompleted () async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('election_completed');

    return (response.data.body as List).map((e) => Election.fromJson(e)).toList();
  }

  Future<List<Election>> getAllNotStarted () async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('election_notStarted');

    return (response.data.body as List).map((e) => Election.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> SecondTour (int id, Map<String, dynamic> data) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.post('second_tour/$id', data: data);

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