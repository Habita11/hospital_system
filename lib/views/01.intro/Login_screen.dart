import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../config/constant_colors.dart';
import '../../config/constant_images.dart';
import '../02.home/home_layout.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void getData() async {}
  bool obscure = true;
  bool isLoading=false;
  IconData iconData = Icons.visibility_off_outlined;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color suffixColor = Colors.grey;
    return BlocConsumer<DevicesCubit,DeviceStates>(
    builder: (context,state){
      DevicesCubit cubit=DevicesCubit.get(context);
      return Scaffold(
        body: Row(
          children: [
            Expanded(
                child: Container(
                  color: AppColors.PRIMARYCOLOR,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome to HEMS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Fredoka",
                            fontWeight: FontWeight.normal,
                            fontSize: 30,
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 500,
                        child: Image(
                          image: AssetImage(AppImages.Doctor),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Fredoka",
                            fontWeight: FontWeight.normal,
                            fontSize: 30,
                            color: Colors.black,
                            letterSpacing: 2),
                      ),
                      DefaultTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "E-mail can not be empty ";
                          }
                        },
                        controller: emailController,
                        iconData: Icons.email,
                        labelText: "E-mail",
                      ),
                      DefaultTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can not be empty";
                          }
                        },
                        suffixColor: suffixColor,
                        controller: passwordController,
                        iconData: Icons.security,
                        labelText: "Password",
                        obscure: obscure,
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {

                              obscure = !obscure;
                              iconData = obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined;
                            });
                          },
                          icon: Icon(iconData),
                        ),
                      ),
                     isLoading? CircularProgressIndicator() : MainButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading=true;
                            });
                            var res = await http.post(
                                Uri.parse(
                                    "https://matted-subtotals.000webhostapp.com/login.php"),
                                body: {
                                  "email": emailController.text,
                                  "password": passwordController.text
                                }).catchError((e){
                                  setState(() {
                                    isLoading=false;
                                  });
                                  showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "something went wrong",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content:  Text(
                                   e.toString()
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),

                                  ],
                                ));});
                            if (jsonDecode(res.body)["status"] == "success") {
                              cubit.user={"e-mail":emailController.text};
                              cubit.getUserData(CurrentUserUpdateState());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      "Wrong credentials",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      "Invalid E-mail or Password"
                                          " \nPlease,make sure and try again",
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),

                                    ],
                                  ));
                            }
                            setState(() {
                              isLoading=false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    },
    listener: (context,state){},
    );
  }
}
