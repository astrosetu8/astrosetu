
import 'dart:convert';

import 'package:dio/dio.dart';
import '../../config/api_route.dart';
import '../../utils/dio_helper.dart';

class LoginRepo {
  Dio dio = DioApi().sendRequest;
  final ApiRoute route = ApiRoute();

  Future<Response> getLogin(String number) async {
    try {
      Dio dio = DioApi().sendRequest;
      var data = json.encode({
        "number": number,
      });
      final response = await dio.post(route.login, data: data );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getVerifyOtp(var data) async {
    try {
      Dio dio = DioApi().sendRequest;

      final response = await dio.post(route.verifyOtp, data: data );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
