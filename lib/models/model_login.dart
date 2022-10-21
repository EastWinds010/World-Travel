class UserLogin {
  String? email;
  String? password;
  UserLogin({this.email, this.password,});
  UserLogin.fromJson(Map data) {
    email = data['email'];
    password = data['password'];
  }
  Map sendToJson() {
    Map data= Map();
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
