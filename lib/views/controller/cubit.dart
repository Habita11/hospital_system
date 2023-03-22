
import 'package:bloc/bloc.dart';
import 'package:cohms/views/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/data_source.dart';
import '../../data/repository/data_repository.dart';
import '../../domain/entities/contract_entities.dart';
import '../../domain/entities/departments_entities.dart';
import '../../domain/entities/device_entities.dart';
import '../../domain/entities/history_entities.dart';
import '../../domain/entities/maintenance_entities.dart';
import '../../domain/entities/stock_entities.dart';
import '../../domain/entities/store_entities.dart';
import '../../domain/entities/suppliers_entities.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repository/device_repository.dart';
import '../../domain/usecases/contract_usecase.dart';
import '../../domain/usecases/ger_device_data_usecase.dart';
import '../../domain/usecases/get_departmenr_usecase.dart';
import '../../domain/usecases/get_stock_data_usecase.dart';
import '../../domain/usecases/get_suppliers_usecase.dart';
import '../../domain/usecases/get_user_data_usecase.dart';
import '../../domain/usecases/history_usecase.dart';
import '../../domain/usecases/maintenance_usecase.dart';
import '../../domain/usecases/storage_usecase.dart';

class DevicesCubit extends Cubit<DeviceStates>{
  DevicesCubit():super(DeviceInitState());
  static DevicesCubit get(context)=>BlocProvider.of(context);

  List<Device> result=[];
  List<Supplier> suppliers=[];
  List<Store> store=[];
  List<Contract> contract=[];
  List<Stock> stock=[];
  List<Maintenance> maintenance=[];
  List<Department> departments=[];
  List<User> users=[];
  List<History> history=[];
  List<Device> devices=[];
  List<Device> devices2=[];
  Map status= {};
  List<User> currentUser=[];
  Map user={};



  BaseDeviceRepository baseDeviceRepository(){
    BaseDataSource baseDataSource=DataSource();
    BaseDeviceRepository baseDeviceRepository=DeviceRepository(baseDataSource);
    return baseDeviceRepository;
  }

  Future<List<Device>> getDevicesData(state)async{
    result=await GetDeviceDataUseCase(baseDeviceRepository()).call();
    emit(state);
    return result;
  }

  Future<List<Maintenance>> getMaintenanceData(state)async{
    List<Device> dev=[];
    Map status={};
    var result=await GetDeviceDataUseCase(baseDeviceRepository()).call();
    maintenance=await GetMaintenanceDataUseCase(baseDeviceRepository()).call();
    maintenance.forEach((e){
      result.forEach((d){
        if(e.deviceName==d.deviceName){
          dev.add(d);
          status.addAll({
            d.deviceCode:e.status
          });
        }
      });
    });
    this.status=status;
    devices=dev;
    emit(state);
    return maintenance;
  }

  Future<List<Department>> getDepartmentData(DeviceStates state)async{
    departments=await GetDepartmentUseCase(baseDeviceRepository()).call();
    emit(state);
    return departments;
  }

  Future<List<User>> getUserData(DeviceStates state)async{
    users=await GetUserDataUseCase(baseDeviceRepository()).call();
    users.forEach((e){
      if(e.email==user["e-mail"]){
        currentUser.add(e);
      }
    });
    emit(state);
    return users;
  }

  Future<List<Supplier>> getSuppliersData(state)async{
    suppliers=await GetSuppliersDataUseCase(baseDeviceRepository()).call();
    emit(state);
    return suppliers;
  }

  Future<List<Stock>> getStockData(state)async{
    stock=await GetStockDataUseCase(baseDeviceRepository()).call();
    emit(state);
    return stock;
  }

  Future<List<Contract>> getContractData(state)async{
    contract=await GetContractUseCase(baseDeviceRepository()).call();
    emit(GetContractState());
    return contract;
  }
  Future<List<Store>> getStoreData()async{
    store=await StorageUseCase(baseDeviceRepository()).call();
    emit(DeviceGetDataState());
    return store;
  }
  Future<List<History>> getHistoryData(state)async{
    List<Device> dev=[];
    var result=await GetDeviceDataUseCase(baseDeviceRepository()).call();
    history=await HistoryUseCase(baseDeviceRepository()).call();
    history.forEach((e){
      result.forEach((d){
        if(e.deviceName==d.deviceName){
          dev.add(d);
        }
      });
    });
    devices2=dev;
    emit(state);
    return history;
  }


}