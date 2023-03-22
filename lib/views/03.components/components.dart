import 'dart:convert';

import 'package:cohms/views/pages/store_page.dart';
import 'package:flutter/cupertino.dart';

import '../../config/data_constants.dart';
import '../../data/data_source/data_source.dart';
import '../../data/repository/data_repository.dart';
import '../../domain/entities/device_entities.dart';
import '../../domain/repository/device_repository.dart';
import '../pages/add_device_screen.dart';
import '../pages/contract_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/devices_page.dart';
import 'package:http/http.dart' as http;

import '../pages/maintenance_page.dart';
import '../pages/settings_page.dart';
import '../pages/stock_page.dart';
import '../pages/suppliers_page.dart';

sendData({required Map body,required String endPoint})async{
var res= await http.post(
      Uri.parse(
          "${DataConstants.baseUrl}/$endPoint.php"),
      body:body ,
);

 return jsonDecode(res.body);
}



main(){
  sendData(body:{
    "name":"Habita",
    "email":"habita11@hems.com",
    "password":"1234456",
    "id":"1",
    "department_code":"2",
    "phone":"01006320722",
  }, endPoint:"signup_update");

}

PageController controller = PageController();
List<Widget> pages=[
   DashboardPage(),
   DevicesPage(),
   MaintenancePage(),
   SettingsPage(),
   AddDeviceScreen(),
  SuppliersPage(),
  ContractPage(),
  StockPage(),
  StorePage()
];
