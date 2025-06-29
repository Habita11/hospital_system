


import 'package:cohms/domain/entities/history_entities.dart';

import '../../domain/entities/contract_entities.dart';
import '../../domain/entities/departments_entities.dart';
import '../../domain/entities/device_entities.dart';
import '../../domain/entities/maintenance_entities.dart';
import '../../domain/entities/stock_entities.dart';
import '../../domain/entities/store_entities.dart';
import '../../domain/entities/suppliers_entities.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repository/device_repository.dart';
import '../data_source/remote/api/data_source.dart';

class DeviceRepository extends BaseDeviceRepository{
  final BaseDataSource baseDataSource;
  DeviceRepository(this.baseDataSource);
  @override
  Future<List<Device>> getDeviceData() {
    return baseDataSource.getDeviceData();
  }

  @override
  Future<List<Maintenance>> getMaintenanceData() {
    return baseDataSource.getMaintenanceData();
  }

  @override
  Future<List<Department>> getDepartmentData() {

    return baseDataSource.getDepartmentData();
  }

  @override
  Future<List<User>> getUserData() {
   return baseDataSource.getUserData();
  }

  @override
  Future<List<Supplier>> getSuppliersData() {

    return baseDataSource.getSupplierData();
  }

  @override
  Future<List<Stock>> getStockData() {
    return baseDataSource.getStockData();
  }

  @override
  Future<List<Contract>> getContractData() {

   return baseDataSource.getContractData();
  }

  @override
  Future<List<Store>> getStorageData() {
    return baseDataSource.getStorageData();
  }

  @override
  Future<List<History>> getHistoryData() {
    return baseDataSource.getHistoryData();
  }

}