
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/constant_colors.dart';
import '../../config/constant_images.dart';
import '../03.components/components.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';
import '../popups/alert_dialog.dart';


class DashboardPage extends StatelessWidget {
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController userDepartmentCodeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formUserKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesCubit, DeviceStates>(
      builder: (context, state) {
        DevicesCubit cubit = DevicesCubit.get(context);
        return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 190,
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              "Total devices",
                              style: TextStyle(color: Colors.grey),
                            ),
                            leading: Image.asset(AppImages.DEVICES),
                            subtitle: Text(
                              "${cubit.result.length}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const Spacer(),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 190,
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              "Users",
                              style: TextStyle(color: Colors.grey),
                            ),
                            leading: Image.asset(AppImages.USERS),
                            subtitle: Text(
                              cubit.users.length.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const Spacer(),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 190,
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              "Devices in maintenance",
                              style: TextStyle(color: Colors.grey),
                            ),
                            leading: Image.asset(AppImages.MAINTENANCE),
                            subtitle: Text(
                              cubit.maintenance.length.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const Spacer(),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 190,
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              "Departments",
                              style: TextStyle(color: Colors.grey),
                            ),
                            leading: Image.asset(AppImages.DEPARTMENTS),
                            subtitle: Text(
                              "${cubit.departments.length}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Departments",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      MainButton(
                        text: "Add Department",
                        iconData: Icons.add,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return MainAlertDialog(
                                    title: "Add Department",
                                    content: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DefaultTextField(
                                              controller:
                                                  departmentNameController,
                                              iconData: Icons.new_label,
                                              labelText: "Department name",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Department name is required !";
                                                }
                                              },
                                            ),
                                            DefaultTextField(
                                              controller:
                                                  departmentCodeController,
                                              iconData: Icons.code,
                                              labelText: "Department code",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Department code is required !";
                                                }
                                              },
                                            ),
                                          ],
                                        )),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              sendData(body: {
                                                "department_name":
                                                    departmentNameController
                                                        .text,
                                                "department_code":
                                                    departmentCodeController
                                                        .text,
                                              }, endPoint: "department_add")
                                                  .then((value) {
                                                if (value["statues"] ==
                                                    "sucess") {

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                    content: Text(
                                                      "Department has been added successfully",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        AppColors.PRIMARYCOLOR,
                                                  ));
                                                  cubit.getDepartmentData(DepartmentUpdateState());
                                                  Navigator.pop(context);
                                                }
                                              });

                                            }
                                          },
                                          child: Text("OK")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel")),
                                    ]);
                              });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: DataTable(
                          dividerThickness: 2,
                          dataRowHeight: 60,
                          columns: const [
                            DataColumn(label: Text("Department code")),
                            DataColumn(label: Text("Department name")),
                            DataColumn(label: Text("Remove")),
                          ],
                          rows: List.generate(
                              cubit.departments.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(cubit.departments[index]
                                            .departmentCode))),
                                    DataCell(Center(
                                        child: Text(cubit.departments[index]
                                            .departmentName))),
                                    DataCell(Center(
                                        child: TextButton(
                                          onPressed: (){
                                            sendData(body: {"department_code":cubit.departments[index].departmentCode},
                                                endPoint: "department_delete").then((value){
                                                  if(value["statues"]=="sucess"){
                                                    cubit.getDepartmentData(DepartmentUpdateState());
                                                    ScaffoldMessenger.of(context).showSnackBar(

                                                      const SnackBar(backgroundColor: AppColors.PRIMARYCOLOR,
                                                          content: Text("Department has been removed successfully",
                                                      style: TextStyle(
                                                        color: Colors.white
                                                      ),))
                                                    );
                                                  }
                                            });
                                          },
                                          child:const Text("Remove",
                                          style: TextStyle(
                                            color: Colors.red
                                          ),),
                                        ))),
                                  ])),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        width: 500,
                        height: 500,
                        child: Column(
                          children: [
                            Expanded(
                              child: PieChart(PieChartData(
                                  centerSpaceColor: Colors.orange,
                                  centerSpaceRadius: 100,
                                  sections: [
                                    PieChartSectionData(
                                      radius: 100,
                                      color: Colors.red,
                                      value:
                                          cubit.maintenance.length.toDouble(),
                                      title:
                                          "${(((cubit.maintenance.length) / (cubit.result.length)) * 100).ceil()}%",
                                      titleStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    PieChartSectionData(
                                      radius: 80,
                                      color: AppColors.PRIMARYCOLOR,
                                      title:
                                          "${((((cubit.result.length) - (cubit.maintenance.length)) / (cubit.result.length))*100).toInt()}%",
                                      titleStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      value: double.parse(
                                          "${(cubit.result.length) - (cubit.maintenance.length)}"),
                                    )
                                  ])),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      color: AppColors.PRIMARYCOLOR,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Active devices",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Need maintenance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                 Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          "Users",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 50,),
                        MainButton(
                          text: "Add User",
                          iconData: Icons.add,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MainAlertDialog(
                                      title: "Add User",
                                      content: Form(
                                          key: formUserKey,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DefaultTextField(
                                                  controller:
                                                  nameController,
                                                  iconData: Icons.account_circle,
                                                  labelText: "User name",
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "User name is required !";
                                                    }
                                                  },
                                                ),
                                                DefaultTextField(
                                                  controller:
                                                  emailController,
                                                  iconData: Icons.email,
                                                  labelText: "E-mail",
                                                  validator: (value){
                                                    if (value!.isEmpty) {
                                                      return "E-mail is required !";
                                                    }
                                                  },
                                                ),
                                                DefaultTextField(
                                                  obscure: true,
                                                  controller:
                                                 passwordController,
                                                  iconData: Icons.security_outlined,
                                                  labelText: "Password",
                                                  validator: (value){
                                                    if (value!.isEmpty) {
                                                      return "Password is required !";
                                                    }
                                                  },
                                                ),

                                                DefaultTextField(
                                                  controller: idController,
                                                  iconData: Icons.credit_card_outlined,
                                                  labelText: "User ID",
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "User ID is required !";
                                                    }
                                                  },
                                                ),
                                                DefaultTextField(
                                                  controller:
                                                 userDepartmentCodeController,
                                                  iconData: Icons.code,
                                                  labelText: "Department code",
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Department code is required !";
                                                    }
                                                  },
                                                ),
                                                DefaultTextField(
                                                  controller:
                                                  phoneController,
                                                  iconData: Icons.phone,
                                                  labelText: "Phone number",
                                                  validator: (value){
                                                    if (value!.isEmpty) {
                                                      return "Phone number is required !";
                                                    }
                                                  },
                                                ),

                                              ],
                                            ),
                                          )),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (formUserKey.currentState!
                                                  .validate()) {
                                                sendData(body: {
                                                  "name": nameController.text,
                                                  "department_code": userDepartmentCodeController.text,
                                                  "id": idController.text,
                                                  "phone": phoneController.text,
                                                  "email": emailController.text,
                                                  "password": userDepartmentCodeController.text,
                                                }, endPoint:"signup")
                                                    .then((value) {
                                                  if (value=="status=>sucess") {
                                                    cubit.getUserData(UserUpdateState());
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                      content: Text(
                                                        "Department has been added successfully",
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                      backgroundColor:
                                                      AppColors.PRIMARYCOLOR,
                                                    ));
                                                    Navigator.pop(context);
                                                  }
                                                });

                                              }
                                            },
                                            child: Text("OK")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel")),
                                      ]);
                                });
                          },
                        )

                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: DataTable(
                      dividerThickness: 2,
                      dataRowHeight: 60,
                      columns: const [
                        DataColumn(label: Text("User ID")),
                        DataColumn(label: Text("User name")),
                        DataColumn(label: Text("E-mail")),
                        DataColumn(label: Text("Phone number")),
                        DataColumn(label: Text("Department code")),
                        DataColumn(label: Text("Remove")),
                      ],
                      rows: List.generate(
                          cubit.users.length,
                          (index) => DataRow(cells: [
                                DataCell(Center(
                                    child: Text(cubit.users[index].userID))),
                                DataCell(Center(
                                    child: Text(cubit.users[index].userName))),
                                DataCell(Center(
                                    child: Text(cubit.users[index].email))),
                                DataCell(Center(
                                    child: Text(cubit.users[index].phone))),
                                DataCell(Center(
                                    child: Text(
                                        cubit.users[index].departmentCode))),
                      DataCell(Center(
                          child: TextButton(
                            onPressed: (){
                              sendData(body: {"id":cubit.users[index].userID},
                                  endPoint: "signup_delete").then((value){
                                if(value["statues"]=="sucess"){
                                  cubit.getUserData(UserUpdateState());
                                  ScaffoldMessenger.of(context).showSnackBar(

                                      const SnackBar(
                                          backgroundColor: AppColors.PRIMARYCOLOR,
                                          content: Text("User has been removed successfully",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),))
                                  );
                                }
                              });
                            },
                            child:const Text("Remove",
                              style: TextStyle(
                                  color: Colors.red
                              ),),
                          ))),
                              ])),
                    ),
                  ),
                ],
              ),
            ));
      },
      listener: (context, state) {},
    );
  }
}
