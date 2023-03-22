import 'package:cohms/views/controller/cubit.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/constant_colors.dart';
import '../03.components/components.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import 'alert_dialog.dart';
import 'dart:convert';
import 'dart:io';

class MainPopUpMenu extends StatelessWidget {
  var image64;
  var imageStore64;


  TextEditingController imageController = TextEditingController();
  TextEditingController imageStoreController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateStoreController = TextEditingController();
  TextEditingController protectiveController = TextEditingController();
  TextEditingController correctiveController = TextEditingController();
  DevicesCubit cubit;
  int index;
  var formKey = GlobalKey<FormState>();
  var formMaintenanceKey = GlobalKey<FormState>();
  var formStoreKey = GlobalKey<FormState>();

  MainPopUpMenu({
    required this.cubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) =>
        [
          PopupMenuItem(
            child: MainButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        MainAlertDialog(
                          title: "Update device data",
                          content: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [

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
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "This field can not be empty";
                                              }
                                            },
                                            controller: roomController,
                                            iconData: Icons.numbers_outlined,
                                            labelText: "Room number",
                                          ),
                                        ]),
                                  ))),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    sendData(body: {
                                      "device_name":
                                      cubit.result[index].deviceName,
                                      "device_code":
                                      cubit.result[index].deviceCode,
                                      "department_code":
                                      cubit.result[index].departmentCode,
                                      "room": roomController.text,
                                      "URL": image64
                                    }, endPoint: 'devices_update')
                                        .then((value) {
                                      if(value["statues"]=="sucess") {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: AppColors.PRIMARYCOLOR,
                                            content: Text("Device data has been updated Successfully",
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),)));
                                        Navigator.pop(context);

                                      }});
                                  }
                                },
                                child: const Text("Ok")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, "update");
                                },
                                child: const Text("Cancel")),
                          ],
                        ));
              },
              text: "UPDATE",
              iconData: Icons.update,

            ),
          ),
          PopupMenuItem(
            child: MainButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        MainAlertDialog(

                          title: "Delete device",
                          content: const Text(
                              "Caution!\nThis device will be deleted permanently !"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  sendData(body: {
                                    "device_code":
                                    cubit.result[index].deviceCode
                                  }, endPoint: "devices_delete")
                                      .then((value) {
                                        cubit.getDevicesData(DeviceUpdateState());
                                    Navigator.pop(context, "update");
                                  });
                                },
                                child: const Text("Ok")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, "update");
                                },
                                child: const Text("Cancel")),
                          ],
                        ));
              },
              color: Colors.red,
              iconData: Icons.delete_forever_sharp,
              text: "DELETE",

            ),
          ),
          PopupMenuItem(
              child:
              MainButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          MainAlertDialog(
                            title: "Add to maintenance",
                            content: SingleChildScrollView(
                                child: Form(
                                  key: formMaintenanceKey,
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          controller: protectiveController,
                                          iconData: Icons.health_and_safety,
                                          labelText: "Protective maintenance",
                                        ),
                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          controller: correctiveController,
                                          iconData: Icons.construction_rounded,
                                          labelText: "Corrective maintenance",
                                        ),

                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          controller: companyIdController,
                                          iconData:Icons.credit_score_rounded ,
                                          labelText: "Company ID",
                                        ),
                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          onTap: () {
                                            showDatePicker(context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate:DateTime(2029) ).then((value){
                                              dateController.text=DateFormat.yMMMMEEEEd().format(value!);
                                            });
                                          },
                                          controller: dateController,
                                          iconData: Icons.date_range_outlined,
                                          labelText: "Date",
                                        ),
                                      ]),
                                )),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (formMaintenanceKey.currentState!
                                        .validate()) {
                                      sendData(body: {
                                        "device_code": cubit.result[index].deviceCode,
                                        "device_startdate": dateController.text,
                                        "department_code": cubit.result[index].departmentCode,
                                        "company_id": companyIdController.text,
                                        "device_status": "Out of service",
                                        "protective_maintainance": protectiveController.text,
                                        "corrective_maintainance": correctiveController.text,
                                        "user_id":cubit.currentUser[0].userID
                                      },
                                          endPoint: "maintainance_add").then((value){
                                        if(value["statues"]=="sucess"){
                                          cubit.getMaintenanceData(MaintenanceUpdateState());
                                          cubit.getDevicesData(DeviceGetDataState());
                                          cubit.getHistoryData(UpdateHistoryState());
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(backgroundColor: AppColors.PRIMARYCOLOR,
                                                  content: Text("Device has been added to maintenance Successfully",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),)));
                                          Navigator.pop(context);
                                        }
                                      });


                                    }
                                  },
                                  child: const Text("Ok")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                            ],
                          ));
                },
                color: Colors.blue,
                iconData: Icons.settings_applications,
                text: "Maintain",
              )
          ),
          PopupMenuItem(
              child:
              MainButton(

                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          MainAlertDialog(
                            title: "Move to storage",
                            content: SingleChildScrollView(
                                child: Form(
                                  key: formStoreKey,
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          controller: reportController,
                                          iconData:Icons.message ,
                                          labelText: "report",
                                        ),
                                        DefaultTextField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field can not be empty";
                                            }
                                          },
                                          onTap: () {
                                            showDatePicker(context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate:DateTime(2029) ).then((value){
                                              dateStoreController.text=DateFormat.yMMMMEEEEd().format(value!);
                                            });
                                          },
                                          controller: dateStoreController,
                                          iconData: Icons.date_range_outlined,
                                          labelText: "Date",
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
                                              imageStore64=base64Encode(file.readAsBytesSync());
                                              imageStoreController.text=file.path;
                                            }
                                          }, icon:Icon(Icons.collections)),
                                          controller: imageStoreController,
                                          iconData: Icons.image,
                                          labelText: "Device image",
                                        ),
                                      ]),
                                )),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (formStoreKey.currentState!
                                        .validate()) {
                                      sendData(body: {
                                        "device_code": cubit.result[index].deviceCode,
                                        "date": dateStoreController.text,
                                        "device_name": cubit.result[index].deviceName,
                                        "report": reportController.text,
                                        "image": imageStore64,

                                      },

                                          endPoint: "store_add").then((value){
                                        if(value["statues"]=="sucess"){
                                          cubit.getStoreData();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(backgroundColor: AppColors.PRIMARYCOLOR,
                                                  content: Text("Device has been added to store Successfully",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),)));
                                          Navigator.pop(context);
                                        }
                                      });
                                      sendData(body: {
                                        "device_code":
                                        cubit.result[index].deviceCode
                                      }, endPoint: "devices_delete")
                                          .then((value) {
                                        cubit.getDevicesData(DeviceUpdateState());
                                        Navigator.pop(context, "update");
                                      });


                                    }
                                  },
                                  child: const Text("Ok")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                            ],
                          ));
                },
                color: Colors.orange,
                iconData: Icons.store,
                text: "Move to storage",
              )
          ),
        ]);
  }
}
