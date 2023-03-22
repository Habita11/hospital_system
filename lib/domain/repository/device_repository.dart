
import '../entities/contract_entities.dart';
import '../entities/departments_entities.dart';
import '../entities/device_entities.dart';
import '../entities/history_entities.dart';
import '../entities/maintenance_entities.dart';
import '../entities/stock_entities.dart';
import '../entities/store_entities.dart';
import '../entities/suppliers_entities.dart';
import '../entities/user_entities.dart';

abstract class BaseDeviceRepository{
Future<List<Device>>getDeviceData();
Future<List<Maintenance>>getMaintenanceData();
Future<List<Department>>getDepartmentData();
Future<List<User>>getUserData();
Future<List<Supplier>>getSuppliersData();
Future<List<Stock>>getStockData();
Future<List<Contract>>getContractData();
Future<List<Store>>getStorageData();
Future<List<History>>getHistoryData();
}