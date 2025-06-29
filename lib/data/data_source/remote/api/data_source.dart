import 'dart:convert';
import 'package:cohms/data/models/history_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../../config/data_constants.dart';
import '../../../../domain/entities/contract_entities.dart';
import '../../../../domain/entities/departments_entities.dart';
import '../../../../domain/entities/history_entities.dart';
import '../../../../domain/entities/stock_entities.dart';
import '../../../../domain/entities/store_entities.dart';
import '../../../../domain/entities/suppliers_entities.dart';
import '../../../../domain/entities/user_entities.dart';
import '../../../models/department_model.dart';
import '../../../models/device_model.dart';
import '../../../models/maintenance_model.dart';
import '../../../models/stock_model.dart';
import '../../../models/suppliers_model.dart';
import '../../../models/user_model.dart';
import '../../../models/contract_model.dart';
import '../../../models/storage_model.dart';



abstract class BaseDataSource {
  Future<List<DeviceModel>> getDeviceData();

  Future<List<MaintenanceModel>> getMaintenanceData();

  Future<List<Department>> getDepartmentData();

  Future<List<User>> getUserData();

  Future<List<Supplier>> getSupplierData();
  Future<List<Stock>> getStockData();
  Future<List<Contract>> getContractData();
  Future<List<Store>> getStorageData();
  Future<List<History>> getHistoryData();
}

class DataSource extends BaseDataSource {
  @override
  Future<List<DeviceModel>> getDeviceData() async {
    final Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/devices_view.php?device_code=0"));
    return List<DeviceModel>.from((json.decode(response.body) as List)
        .map((e) => DeviceModel.fromJSON(e)));
  }

  @override
  Future<List<MaintenanceModel>> getMaintenanceData() async {
    final Response response = await http.post(Uri.parse(
        "${DataConstants.baseUrl}/maintainance_view.php?device_code=0"));
    return List<MaintenanceModel>.from((json.decode(response.body) as List)
        .map((e) => MaintenanceModel.fromJSON(e)));
  }

  @override
  Future<List<Department>> getDepartmentData() async {
    Response response = await http.post(Uri.parse(
        "${DataConstants.baseUrl}/department_view.php?department_code=0"));
    return List<DepartmentModel>.from(
        (json.decode(response.body)).map((e) => DepartmentModel.fromJSON(e)));
  }

  @override
  Future<List<User>> getUserData() async {
    Response response = await http
        .post(Uri.parse("${DataConstants.baseUrl}/signup_view.php?id=0"));
    return List<UserModel>.from(
        (json.decode(response.body)).map((e) => UserModel.fromJSON(e)));
  }

  @override
  Future<List<Supplier>> getSupplierData() async {
    Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/suppliers_view.php?part_id=0"));
    return List<SupplierModel>.from((json.decode(response.body)).map((e) =>
        SupplierModel.fromJson(e)));
  }

  @override
  Future<List<Stock>> getStockData() async{
    Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/stock_view.php?part_id=0"));
    return List<StockModel>.from((json.decode(response.body)).map((e) =>
        StockModel.fromJSON(e)));
  }

  @override
  Future<List<Contract>> getContractData()async {
    Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/contract_view.php?company_id=0"));
    return List<ContractModel>.from((json.decode(response.body)).map((e) =>
        ContractModel.fromJson(e)));
  }

  @override
  Future<List<Store>> getStorageData() async{
    Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/store_view.php?device_code=0"));
    return List<StorageModel>.from((jsonDecode(response.body)).map((e)=>StorageModel.fromJson(e)));
  }

  @override
  Future<List<History>> getHistoryData() async{
    Response response = await http.post(
        Uri.parse("${DataConstants.baseUrl}/history_view.php?device_code=0"));
    return List<HistoryModel>.from((jsonDecode(response.body)).map((e)=>HistoryModel.fromJSON(e)));
  }
}

main() {
  getData();
}

Future getData() async {
  var response = await http.post(
    Uri.parse("${DataConstants.baseUrl}/devices_view.php?device_code=0"),
  );
  print(response.body);
  print(response.statusCode);
}

Future addData() async {
  var response = await http.post(
      Uri.parse(
          "https://matted-subtotals.000webhostapp.com/maintainance_add.php"),
      body: {
        "device_code": "1532",
        "department_code": "2",
        "device_startdate": "2022-11-11",
        "protective_maintainance": "true",
        "corrective_maintainance": "false",
        "device_status": "Active",
        "company_id": "2"
      });
  print(response.body);
  print(response.statusCode);
}
