import 'dart:convert';

import 'package:dio/dio.dart';
import '../../config/api_route.dart';
import '../../config/share_pref.dart';
import '../../utils/dio_helper.dart';

class AstrologerRepo {
  Dio dio = DioApi().sendRequest;
  final ApiRoute route = ApiRoute();

  Future<Response> getAstrologer({required String tab}) async {
    try {
      String? token = await getAccessToken();
      print("token find  $token");

      Dio dio = DioApi(isHeader: true, token: token).sendRequestForAuth;

      final response = await dio.get("${route.astrologers}${tab}");
      print("responce data >>>>> ${response}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //By id
  Future<Response> getAstrologerById(String id) async {
    try {
      String? token = await getAccessToken();
      print("token find  $token");

      Dio dio = DioApi(isHeader: true, token: token).sendRequestForAuth;

      final response = await dio.get("${route.astrologers}$id");

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
