import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';

class CreateUser {
  final CustomHttp _http = CustomHttp();
  Future<dynamic> registerUser(Map body) async {
    try {
      Response response =
          await _http.client.post(Endpoint.createUSER, data: json.encode(body));
      return response.statusCode;
      print(response.data);
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }
}
