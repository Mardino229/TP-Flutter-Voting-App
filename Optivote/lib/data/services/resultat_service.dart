import 'package:dio/dio.dart';
import 'package:optivote/data/models/resultat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_instance.dart';

class ResultatService {

  Dio api = configureDio();

  Future<List<Resultat>> getAll (String election_id) async{

    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    final response = await api.get('resultats/$election_id');

    return (response.data["body"] as List).map((e) => Resultat.fromJson(e)).toList();
  }

}