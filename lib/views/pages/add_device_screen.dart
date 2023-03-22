import 'dart:convert';
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../config/constant_colors.dart';
import '../03.components/components.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';

class AddDeviceScreen extends StatelessWidget {
  TextEditingController deviceNameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController deviceCodeController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  var image64;
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesCubit,DeviceStates>(
      builder: (context,state){
        DevicesCubit cubit=DevicesCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
            ),
            child:
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              child: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(onPressed: (){
                                      controller.jumpToPage(0);
                                    }, icon: Icon(Icons.arrow_back_ios)),
                                  ),
                                  DefaultTextField(
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return "This field can not be empty";
                                      }
                                    } ,
                                    controller: deviceNameController,
                                    iconData: Icons.devices,
                                    labelText: "Device name",
                                  ),
                                  DefaultTextField(
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return "This field can not be empty";
                                      }
                                    } ,
                                    controller: deviceCodeController,
                                    iconData: Icons.security_outlined,
                                    labelText: "Device code",
                                  ),
                                  DefaultTextField(
                                    suffix: PopupMenuButton( icon: Icon(Icons.keyboard_arrow_down_outlined),
                                      itemBuilder: (BuildContext context) {
                                      return List.generate(cubit.departments.length, (index) =>
                                          PopupMenuItem(onTap: (){
                                            departmentCodeController.text=cubit.departments[index].departmentCode;
                                          },
                                              child: Text(cubit.departments[index].departmentName)));
                                    },),
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return "This field can not be empty";
                                      }
                                    } ,
                                    controller: departmentCodeController,
                                    iconData: Icons.dataset_outlined,
                                    labelText: "Department code",
                                  ),
                                  DefaultTextField(
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return "This field can not be empty";
                                      }
                                    } ,
                                    suffix: IconButton(onPressed: ()async{
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.image
                                      );
                                      if (result != null) {
                                        File file=File(result.files.single.path!);
                                         image64=base64Encode(file.readAsBytesSync());
                                         imageController.text=file.path;
                                      }
                                    }, icon:Icon(Icons.collections)),
                                    controller: imageController,
                                    iconData: Icons.image,
                                    labelText: "Device image",
                                  ),
                                  DefaultTextField(
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return "This field can not be empty";
                                      }
                                    } ,
                                    controller: roomController,
                                    iconData: Icons.numbers_outlined,
                                    labelText: "Room number",
                                  ),
                                  MainButton(
                                    text: "ADD DEVICE",
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        sendData(
                                            body: {
                                          "device_name":deviceNameController.text,
                                          "device_code":deviceCodeController.text,
                                          "department_code":departmentCodeController.text,
                                          "room":roomController.text,
                                          "URL":image64
                                        },
                                            endPoint: "devices_add"
                                        ).then((value){
                                          if(value["statues"]=="sucess"){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(backgroundColor: AppColors.PRIMARYCOLOR,
                                                    content: Text("Device has been added successfully",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),))
                                            );
                                          }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                               const SnackBar(backgroundColor: Colors.red,
                                                    content: Text("Failed to add this device",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),))
                                            );
                                          }
                                        });
                                      }},
                                  )
                                ]),
                          ),
                        )),
                  ),
            )
          ),
        );
      },
      listener: (context,state){},

    );
  }
}
