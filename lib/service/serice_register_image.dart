import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';

class ServiceRegisterImage {
  CustomHttp _http = CustomHttp();
  Future<dynamic> registerIamge(Map body) async {
    try {
      Response response = await _http.client
          .post(Endpoint.registerImage, data: jsonEncode(body));
      return response.data['DATA'];
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
