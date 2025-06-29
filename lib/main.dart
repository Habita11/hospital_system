import 'dart:io';
import 'package:cohms/config/constant_colors.dart';
import 'package:cohms/views/01.intro/splash_screen.dart';
import 'package:cohms/views/02.home/home_layout.dart';
import 'package:cohms/views/controller/cubit.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:cohms/views/dummy_view.dart';
import 'package:cohms/views/pages/devices_page.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data_source/remote/api/data_source.dart';
import 'data/repository/data_repository.dart';
import 'domain/repository/device_repository.dart';
import 'domain/usecases/ger_device_data_usecase.dart';
import 'views/01.intro/Login_screen.dart';
import 'views/pages/add_device_screen.dart';
import 'views/03.components/components.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(Size(1700, 900));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>DevicesCubit()..getDepartmentData(DepartmentGetState())
      ..getUserData(UserGetState())..getMaintenanceData(MaintenanceGetState())
          ..getDevicesData(DeviceGetDataState())..getContractData(GetContractState())..getStockData(GetStockState())
          ..getSuppliersData(GetSuppliersState())..getStoreData()..getHistoryData(GetHistoryState()),
    child:MaterialApp(
      theme: ThemeData.light().copyWith(colorScheme:const ColorScheme.light(primary: AppColors.PRIMARYCOLOR)),
        title: "Hospital equipments management system",
        debugShowCheckedModeBanner: false,
        home:SplashScreen()));
  }
}
