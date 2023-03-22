import 'package:cohms/domain/usecases/ger_device_data_usecase.dart';
import 'package:cohms/views/03.components/components.dart';
import 'package:cohms/views/controller/cubit.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:cohms/views/pages/add_device_screen.dart';
import 'package:cohms/views/03.components/main_button.dart';
import 'package:cohms/views/pages/devices_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesCubit,DeviceStates>(
     builder: (context,state){
       DevicesCubit cubit=DevicesCubit.get(context);
       return Padding(
         padding: const EdgeInsets.all(10.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 const Text(
                   "Devices",
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                 ),
                 Spacer(),
                 MainButton(
                   onPressed: () {
                     controller.jumpToPage(4);
                   },
                   text: "ADD DEVICE",
                   iconData: Icons.add,
                 ),
                 const SizedBox(
                   width: 10,
                 ),
               ],
             ),
             const SizedBox(
               height: 20,
             ),
             DevicesGridview()
           ],
         ),
       );
     },
     listener: (context,state){},
    );
  }
}
