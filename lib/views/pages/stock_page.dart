import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/constant_colors.dart';
import '../03.components/components.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';
import '../popups/alert_dialog.dart';

class StockPage extends StatelessWidget {


  var formKey =GlobalKey<FormState>();

TextEditingController partIdController =TextEditingController();
TextEditingController partNameController =TextEditingController();
TextEditingController partNumController =TextEditingController();
TextEditingController departmentCodeController =TextEditingController();

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
                  "Stock",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                MainButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => MainAlertDialog(
                          title: "Add to stock",
                          content: SingleChildScrollView(
                              child: Form(
                                key: formKey,
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
                                        controller: partIdController,
                                        iconData: Icons.credit_card_outlined,
                                        labelText: "Part ID",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        controller:partNameController,
                                        iconData: Icons.code,
                                        labelText: "Part name",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        controller: partNumController,
                                        iconData: Icons.numbers_outlined,
                                        labelText: "Part Number",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        suffix:  PopupMenuButton( icon: Icon(Icons.keyboard_arrow_down_outlined),
                                          itemBuilder: (BuildContext context) {
                                            return List.generate(cubit.departments.length, (index) =>
                                                PopupMenuItem(onTap: (){
                                                  departmentCodeController.text=cubit.departments[index].departmentCode;
                                                },
                                                    child: Text(cubit.departments[index].departmentName)));
                                          },),
                                        controller: departmentCodeController,
                                        iconData: Icons.code,
                                        labelText: "Department code",
                                      ),
                                    ]),
                              )),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (formKey.currentState!
                                      .validate()) {
                                    sendData(body: {
                                      "part_id":partIdController.text,
                                      "part_name":partNameController.text,
                                      "part_numbers":partNumController.text,
                                      "department_code":departmentCodeController.text,
                                    }, endPoint: "stock_add")
                                        .then((value) {
                                      if (value["statues"] == "sucess") {
                                        cubit.getStockData(UpdateStockState());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            backgroundColor:
                                            AppColors.PRIMARYCOLOR,
                                            content: Text(
                                              "Part has been added Successfully",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
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
                  iconData: Icons.add,
                  text: "Add Part",
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: DataTable(
                    dividerThickness: 2,
                    dataRowHeight: 60,
                    columns: const [
                      DataColumn(label: Text("Part ID")),
                      DataColumn(label: Text("Part name")),
                      DataColumn(label: Text("Part number")),
                      DataColumn(label: Text("Department code")),
                      DataColumn(label: Text("Department name")),
                      DataColumn(label: Text("Remove")),
                    ],
                    rows: List.generate(
                        cubit.stock.length,
                            (index) => DataRow(cells: [
                          DataCell(Center(
                              child:
                              Text(cubit.stock[index].partId))),
                          DataCell(Center(
                              child:
                              Text(cubit.stock[index].partName))),
                          DataCell(Center(
                              child: Text(cubit.stock[index].partNum))),
                          DataCell(Center(
                              child: Text(cubit.stock[index].departmentCode))),
                          DataCell(Center(
                              child: Text(cubit.stock[index].departmentName))),
                          DataCell(Center(child: TextButton(
                            child: Text("Remove",
                              style: TextStyle(
                                  color: Colors.red),),
                            onPressed: (){
                              sendData(body: {
                                "part_id": cubit.stock[index].partId,
                              }, endPoint: "stock_delete")
                                  .then((value) {
                                if (value["statues"] == "sucess") {
                                  cubit.getStockData(UpdateStockState());
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      backgroundColor: AppColors
                                          .PRIMARYCOLOR,
                                      content: Text(
                                        "Device has been removed Successfully",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),)));
                                }
                              });

                            },))),
                        ])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
