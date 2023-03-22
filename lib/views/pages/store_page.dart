import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit.dart';
import '../controller/states.dart';


class StorePage extends StatelessWidget {
 ScrollController controller=ScrollController();

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
                  "Storage",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Scrollbar(
                    controller:controller ,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      child: DataTable(
                        dividerThickness: 2,
                        dataRowHeight: 100,

                        columns: const [
                          DataColumn(label: Text("Image")),
                          DataColumn(label: Text("Device code")),
                          DataColumn(label: Text("Device name")),
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Report")),

                        ],
                        rows: List.generate(
                            cubit.store.length,
                                (index) => DataRow(cells: [
                              DataCell(Center(
                                  child:
                                  Image.memory(base64Decode(cubit.store[index].image,
                                  )))),
                              DataCell(Center(
                                  child:
                                  Text(cubit.store[index].deviceCode))),
                              DataCell(Center(
                                  child: Text(cubit.store[index].deviceName))),
                              DataCell(Center(
                                  child: Text(cubit.store[index].date))),
                              DataCell(Center(
                                  child: Text(cubit.store[index].report))),

                            ])),
                      ),
                    ),
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
