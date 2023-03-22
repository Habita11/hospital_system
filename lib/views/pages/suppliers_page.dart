import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/constant_colors.dart';
import '../03.components/components.dart';
import '../03.components/main_button.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';
import '../popups/alert_dialog.dart';

class SuppliersPage extends StatelessWidget {
  var formKey =GlobalKey<FormState>();

  TextEditingController partIdController =TextEditingController();
  TextEditingController partNameController =TextEditingController();
  TextEditingController partPriceController =TextEditingController();
  TextEditingController deviceCodeController =TextEditingController();
  TextEditingController companyIdController =TextEditingController();
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
                  "Suppliers",
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
                          title: "Add to suppliers",
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
                                        controller: partPriceController,
                                        iconData: Icons.attach_money,
                                        labelText: "Part price",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        controller: companyIdController,
                                        iconData: Icons.code_sharp,
                                        labelText: "Company ID",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        suffix:  PopupMenuButton( icon: Icon(Icons.keyboard_arrow_down_outlined),
                                          itemBuilder: (BuildContext context) {
                                            return List.generate(cubit.result.length, (index) =>
                                                PopupMenuItem(onTap: (){
                                                  deviceCodeController.text=cubit.result[index].deviceCode;
                                                },
                                                    child: Text(cubit.departments[index].departmentName)));
                                          },),
                                        controller: deviceCodeController,
                                        iconData: Icons.numbers_outlined,
                                        labelText: "Device code",
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
                                      "part_price":partPriceController.text,
                                      "device_code":deviceCodeController.text,
                                      "company_id":companyIdController.text,
                                    }, endPoint: "suppliers_add")
                                        .then((value) {
                                      if (value["statues"] == "sucess") {
                                        cubit.getSuppliersData(UpdateSuppliersState());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            backgroundColor:
                                            AppColors.PRIMARYCOLOR,
                                            content: Text(
                                              "Supplier has been added Successfully",
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
                  text: "Add supplier",
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
                      DataColumn(label: Text("Part price")),
                      DataColumn(label: Text("company code")),
                      DataColumn(label: Text("company name")),
                      DataColumn(label: Text("Remove")),
                    ],
                    rows: List.generate(
                        cubit.suppliers.length,
                            (index) => DataRow(cells: [
                          DataCell(Center(
                              child:
                              Text(cubit.suppliers[index].partId!))),
                          DataCell(Center(
                              child:
                              Text(cubit.suppliers[index].partName!))),
                          DataCell(Center(
                              child: Text(cubit.suppliers[index].partPrice!))),
                          DataCell(Center(
                              child: Text(cubit.suppliers[index].companyId!))),
                          DataCell(Center(
                              child: Text(cubit.suppliers[index].companyName!))),
                          DataCell(Center(child: TextButton(
                            child: Text("Remove",
                              style: TextStyle(
                                  color: Colors.red),),
                            onPressed: (){
                              sendData(body: {
                                "part_id": cubit.suppliers[index].partId,
                              }, endPoint: "suppliers_delete")
                                  .then((value) {
                                if (value["statues"] == "sucess") {
                                  cubit.getSuppliersData(UpdateSuppliersState());
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      backgroundColor: AppColors
                                          .PRIMARYCOLOR,
                                      content: Text(
                                        "Supplier has been removed Successfully",
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
