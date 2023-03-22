import 'package:cohms/views/popups/popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../03.components/device_card.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';

class DevicesGridview extends StatelessWidget {
  TextEditingController deviceNameController = TextEditingController();
  TextEditingController deviceCodeController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesCubit, DeviceStates>(
        builder: (context,state) {
          DevicesCubit cubit = DevicesCubit.get(context);
          return Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(
                cubit.result.length,
                    (index) => DeviceCard(
                  cubit: cubit,
                  index: index,
                  widget: MainPopUpMenu(cubit: cubit, index: index),
                  device:cubit.result[index],
                  // widget: Container(),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      );

  }
}
