import 'dart:convert';

import 'package:cohms/views/03.components/components.dart';
import 'package:cohms/views/controller/cubit.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/constant_colors.dart';

class MaintenancePage extends StatelessWidget {

  ScrollController scrollController=ScrollController();
  ScrollController scrollController2=ScrollController();

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<DevicesCubit,DeviceStates>(
     builder: (context,state){
       DevicesCubit cubit=DevicesCubit.get(context);
       return Padding(
         padding: const EdgeInsets.all(10.0),
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               const Text(
                 "Maintenance",
                 style: TextStyle(
                     fontWeight: FontWeight.bold, fontSize: 30),
               ),
               const SizedBox(height: 20,),
               Scrollbar(
                 controller: scrollController,
                 thumbVisibility: true,
                 child: SingleChildScrollView(
                   controller: scrollController,
                   scrollDirection: Axis.horizontal,
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: DataTable(
                       dividerThickness: 2,
                       dataRowHeight: 110,
                       columns: const [
                         DataColumn(label: Text("Image")),
                         DataColumn(label: Text("Device Name")),
                         DataColumn(label: Text("Device Code")),
                         DataColumn(label: Text("Department Name")),
                         DataColumn(label: Text("Department Code")),
                         DataColumn(label: Text("Status")),
                         DataColumn(label: Text("Company Name")),
                         DataColumn(label: Text("Company ID")),
                         DataColumn(
                             label: Text("Corrective maintenance")),
                         DataColumn(
                             label: Text("Protective maintenance")),
                         DataColumn(label: Text("Start date")),
                         DataColumn(label: Text("Remove device")),

                       ],
                       rows:
                       List.generate(cubit.maintenance.length, (index) =>
                           DataRow(
                               cells: [
                                 DataCell(Image.memory(
                                   base64Decode(cubit.devices[index].imageURL!),
                                   gaplessPlayback: true,
                                   fit: BoxFit.cover,
                                   width: 200,
                                   height: 100,
                                 ),),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .deviceName!)),
                                 ),
                                 DataCell(Center(child: Text(
                                     cubit.devices[index].deviceCode))),
                                 DataCell(Center(child: Text(
                                     cubit.devices[index]
                                         .department))),
                                 DataCell(Center(child: Text(
                                     cubit.devices[index]
                                         .departmentCode))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index].status!))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .companyName!))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .companyId!))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .correctiveMaintenance!))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .protectiveMaintenance!))),
                                 DataCell(Center(child: Text(
                                     cubit.maintenance[index]
                                         .startDate!))),
                                 DataCell(Center(child: TextButton(

                                   child: Text("Remove",
                                     style: TextStyle(
                                         color: Colors.red),),
                                   onPressed: (){
                                     sendData(body: {
                                       "device_code": cubit.devices[index].deviceCode,
                                       "device_startdate": cubit
                                           .maintenance[index].startDate
                                     }, endPoint: "maintainance_delete")
                                         .then((value) {
                                       if (value["statues"] == "sucess") {
                                         cubit.getMaintenanceData(MaintenanceUpdateState());
                                         cubit.getDevicesData(DeviceUpdateState());
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

                               ]))

                       ,

                     ),
                   ),
                 ),
               ),
               const SizedBox(height: 20,),
               const Text(
                 "Maintenance History",
                 style: TextStyle(
                     fontWeight: FontWeight.bold, fontSize: 30),
               ),
               Scrollbar(
                 controller: scrollController2,
                 thumbVisibility: true,
                 child: SingleChildScrollView(
                   controller: scrollController2,
                   scrollDirection: Axis.horizontal,
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: DataTable(
                       dividerThickness: 2,
                       dataRowHeight: 110,
                       columns: const [
                         DataColumn(label: Text("Image")),
                         DataColumn(label: Text("Device Name")),
                         DataColumn(label: Text("Device Code")),
                         DataColumn(label: Text("Department Name")),
                         DataColumn(label: Text("Department Code")),
                         DataColumn(label: Text("Status")),
                         DataColumn(label: Text("Company Name")),
                         DataColumn(label: Text("Company ID")),
                         DataColumn(
                             label: Text("Corrective maintenance")),
                         DataColumn(
                             label: Text("Protective maintenance")),
                         DataColumn(label: Text("Start date")),
                         DataColumn(label: Text("User id")),


                       ],
                       rows:
                       List.generate(cubit.history.length, (index) =>
                           DataRow(
                               cells: [
                                 DataCell(Image.memory(
                                   base64Decode(cubit.devices2[index].imageURL!),
                                   gaplessPlayback: true,
                                   fit: BoxFit.cover,
                                   width: 200,
                                   height: 100,
                                 ),),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .deviceName!)),
                                 ),
                                 DataCell(Center(child: Text(
                                     cubit.devices2[index].deviceCode))),
                                 DataCell(Center(child: Text(
                                     cubit.devices2[index]
                                         .department))),
                                 DataCell(Center(child: Text(
                                     cubit.devices2[index]
                                         .departmentCode))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index].status!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .companyName!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .companyId!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .correctiveMaintenance!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .protectiveMaintenance!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .startDate!))),
                                 DataCell(Center(child: Text(
                                     cubit.history[index]
                                         .userId!))),

                               ]))

                       ,

                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       );

     },
     listener: (context,state){},
   );

  }
}
