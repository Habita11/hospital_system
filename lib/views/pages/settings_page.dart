import 'package:cohms/config/constant_colors.dart';
import 'package:cohms/config/constant_images.dart';
import 'package:cohms/views/03.components/components.dart';
import 'package:cohms/views/03.components/main_button.dart';
import 'package:cohms/views/03.components/text_form_field.dart';
import 'package:cohms/views/controller/cubit.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController idController = TextEditingController();

  TextEditingController departmentCodeController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  var error;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesCubit, DeviceStates>(
      builder: (context, state) {
        DevicesCubit cubit = DevicesCubit.get(context);
        emailController.text = cubit.currentUser[0].email;
        phoneController.text = cubit.currentUser[0].phone;
        idController.text = cubit.currentUser[0].userID;
        departmentCodeController.text = cubit.currentUser[0].departmentCode;
        nameController.text = cubit.currentUser[0].userName;
        return Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 30,
                            child: Icon(
                              Icons.account_circle,
                              color: AppColors.PRIMARYCOLOR,
                              size: 50,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.currentUser[0].userName,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "This field can not be empty";
                          }
                        },
                        controller: nameController,
                        iconData: Icons.account_circle,
                        labelText: "User name"),
                    DefaultTextField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "This field can not be empty";
                        }
                      },
                        controller: emailController,
                        iconData: Icons.email_outlined,
                        labelText: "E-mail"),

                    DefaultTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "This field can not be empty";
                          }
                        },
                        isEnabled: false,
                        controller: idController,
                        iconData: Icons.credit_card_outlined,
                        labelText: "User ID"),
                    DefaultTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "This field can not be empty";
                          }
                        },
                        controller: phoneController,
                        iconData: Icons.phone,
                        labelText: "Phone"),
                    DefaultTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "This field can not be empty";
                          }
                        },
                        isEnabled: false,
                        controller: departmentCodeController,
                        iconData: Icons.code_sharp,
                        labelText: "Department code"),
                    Row(
                      children: [
                        const SizedBox(
                          width: 150,
                        ),
                        MainButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                            sendData(body:{
                              "name":nameController.text,
                              "email":emailController.text,
                              "password":cubit.currentUser[0].password,
                              "id":idController.text,
                              "department_code":departmentCodeController.text,
                              "phone":phoneController.text,
                            }, endPoint:"signup_update").then((value){
                              try{if(value["statues"=="sucess"]){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  backgroundColor: AppColors.PRIMARYCOLOR,
                                    content:Text("User data updated successfully",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),)
                                ));
                              }}catch(e){
                               error=e.toString();
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                   backgroundColor: Colors.red,
                                   content:Text("failed",
                                   style: TextStyle(
                                   color: Colors.white
                               ))));
                              }
                            });
                            cubit.getUserData(UserUpdateState());

                          }},
                          iconData: Icons.update,
                          text: "UPDATE DATA",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
