
import 'dart:convert';

import 'package:dio/dio.dart';
import '../../config/api_route.dart';
import '../../config/share_pref.dart';
import '../../utils/dio_helper.dart';

class ProfileRepo {
  Dio dio = DioApi().sendRequest;
  final ApiRoute route = ApiRoute();

  Future<Response> updateProfile(var data) async {
    try {
      String? token = await getAccessToken();
      print("token find  $token");
      Dio dio = DioApi(isHeader: true,token: token).sendRequestForAuth;


      final response = await dio.put(route.updateProfile, data: data );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
