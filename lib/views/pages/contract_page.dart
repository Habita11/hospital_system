import 'package:cohms/views/03.components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../config/constant_colors.dart';
import '../03.components/components.dart';
import '../03.components/text_form_field.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';
import '../popups/alert_dialog.dart';

class ContractPage extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  TextEditingController companyNameController=TextEditingController();
  TextEditingController companyIdController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController durationController=TextEditingController();
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
                  "Contract",
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
                              title: "Add to contract",
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
                                        controller: companyNameController,
                                        iconData: Icons.credit_card_outlined,
                                        labelText: "Company name",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        controller: companyIdController,
                                        iconData: Icons.code,
                                        labelText: "Company ID",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        controller: durationController,
                                        iconData: Icons.watch_later_outlined,
                                        labelText: "Duration",
                                      ),
                                      DefaultTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field can not be empty";
                                          }
                                        },
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2029))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMMEEEEd()
                                                    .format(value!);
                                          });
                                        },
                                        controller: dateController,
                                        iconData: Icons.date_range_outlined,
                                        labelText: "Initial Date",
                                      ),
                                    ]),
                              )),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!
                                          .validate()) {
                                        sendData(body: {
                                          "company_id":companyIdController.text,
                                          "company_name":companyNameController.text,
                                          "duration":durationController.text,
                                          "instulltion_date":dateController.text,
                                          "maintainance_condition":"hfd"

                                        }, endPoint: "contract_add")
                                            .then((value) {
                                          if (value["statues"] == "sucess") {
                                            cubit.getContractData(UpdateContractState());
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        AppColors.PRIMARYCOLOR,
                                                    content: Text(
                                                      "Contract has been added Successfully",
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
                  text: "Add contract",
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
                      DataColumn(label: Text("Company ID")),
                      DataColumn(label: Text("Company name")),
                      DataColumn(label: Text("Initial date")),
                      DataColumn(label: Text("Duration")),
                      DataColumn(label: Text("Remove")),
                    ],
                    rows: List.generate(
                        cubit.contract.length,
                        (index) => DataRow(cells: [
                              DataCell(Center(
                                  child:
                                      Text(cubit.contract[index].companyId))),
                              DataCell(Center(
                                  child:
                                      Text(cubit.contract[index].companyName))),
                              DataCell(Center(
                                  child: Text(cubit.contract[index].instDate))),
                              DataCell(Center(
                                  child: Text(cubit.contract[index].duration))),
                          DataCell(Center(child: TextButton(
                            child: Text("Remove",
                              style: TextStyle(
                                  color: Colors.red),),
                            onPressed: (){
                              sendData(body: {
                                "company_id": cubit.contract[index].companyId,
                              }, endPoint: "contract_delete")
                                  .then((value) {
                                if (value["statues"] == "sucess") {
                                 cubit.getContractData(UpdateContractState());
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
