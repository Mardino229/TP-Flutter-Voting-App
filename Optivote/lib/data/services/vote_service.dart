import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_instance.dart';

class VoteService {

  Dio api = configureDio();

  Future<Map<String, dynamic>> vote (Map<String, dynamic> data) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.post('vote', data: data);

    if (response.statusCode == 422) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }

    return response.data;
  }

  Future<Map<String, dynamic>> verifyVote (String election_id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    int? user_id = pref.getInt("id") ?? null;

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('vote/$election_id/${user_id.toString()}');

    return response.data;
  }

}