import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_dart/models/model_image.dart';
import 'package:learning_dart/models/model_create_user.dart';
import 'package:learning_dart/service/serice_register_image.dart';
import 'package:learning_dart/service/service_create_user.dart';

class ControllerRegister {
  //variáveis
  XFile? file;
  ImageModel? imageModel;
  UserModel? userModel;
  VoidCallback? updateState;
  bool loading = false;
  ServiceRegisterImage serviceRegisterImage = ServiceRegisterImage();
  CreateUser createUser = CreateUser();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();
  TextEditingController displayName = TextEditingController();
  String verificedPassword = '';
  bool showPass = true;
  bool showRepeatPass = true;

  Future<void> getImage(ImageSource source) async {
    XFile? imageReq = await ImagePicker.platform.getImage(source: source);
    file = imageReq;
  }

  Future<String> convertImage() async {
    List<int> imageBytes = await file!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<void> buildContextBody(BuildContext context) async {
    List<String> param = file!.path.split('/');
    List<String> paramSufix = param.last.toString().split('.');
    String fileName = paramSufix.first;
    String ext = '.' + paramSufix.last;
    String mimetype = 'image/' + paramSufix.last;
    imageModel = ImageModel();
    Map<String, dynamic> data = {
      "base64": await convertImage(),
      "extension": ext,
      "fileName": fileName,
      "mimetype": mimetype
    };
    imageModel = ImageModel.fromJson(data);
    await serviceRegisterImage
        .registerIamge(imageModel!.sendToJson())
        .then((value) async {
      if (value != null) {
        String photoUrl = value['docfile'];
        userModel = UserModel();
        Map user = {
          "displayName": displayName.text,
          "email": email.text,
          "password": password.text,
          "photoUrl": photoUrl,
        };
        userModel = UserModel.fromJson(user);
        print(user);
        await createUser.registerUser(userModel!.sendToJson()).then((result) {
          print(result);
          switch (result) {
            case 200:
              Fluttertoast.showToast(msg: 'Cadastro Realizado com Sucesso!');
              Navigator.pushReplacementNamed(context, '/login_screen');
              break;
            case null:
              Fluttertoast.showToast(
                msg: 'E-mail ja cadastrado',
                toastLength: Toast.LENGTH_LONG,
              );
              break;
            default:
          }
        });
      } else {
        print('Erro');
      }
    });
  }
}
