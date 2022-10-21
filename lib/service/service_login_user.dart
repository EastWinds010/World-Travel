import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLoginUser {
  final CustomHttp _http = CustomHttp();
  Future<dynamic> loginUser(Map body) async {
    try {
      Response response =
          await _http.client.post(Endpoint.loginUSER, data: body);
      void setUsers() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences
            .setString(
                'Token',
                response.data['DATA']['userLoged']['user']['stsTokenManager']
                    ['accessToken'])
            .toString();
        String userId = preferences
            .setString(
                'userId', response.data['DATA']['userLoged']['user']['uid'])
            .toString();
      }
      setUsers();
      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      print(e.message);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }

  Future<dynamic> getUsers() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('Token').toString();
      String userId = preferences.getString('userId').toString();

      Map<String, dynamic> headers = {
        "Authorization": "Bearer " + token,
      };
      Response response = await _http.client.get(
          Endpoint.getUSER + userId,
          options: Options(headers: headers));
      int teste = response.statusCode!.ceil();
      Future<bool> validator = preferences.setInt('Validator', teste);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }
}
