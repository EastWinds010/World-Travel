import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.text,
      required this.controller,
      this.validator,
      required this.showPassword,
      required this.isPass,
      this.changeShowPassword,
      })
      : super(key: key);

  final String text;
  final TextEditingController controller;
  late String? Function(String?)? validator;
  final bool showPassword;
  final bool isPass;
  final VoidCallback? changeShowPassword;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: size.width * .06, fontFamily: 'RobotoRegular'),
              ),
              isPass
                  ? IconButton(
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: changeShowPassword,
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: TextFormField(
            validator: validator,
            controller: controller,
            obscureText: showPassword,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black)),
            ),
          ),
        )
      ],
    );
  }
}
