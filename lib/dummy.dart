
import 'package:cohms/data/data_source/data_source.dart';
import 'package:cohms/data/repository/data_repository.dart';
import 'package:cohms/domain/repository/device_repository.dart';
import 'package:cohms/domain/usecases/contract_usecase.dart';
import 'package:cohms/domain/usecases/ger_device_data_usecase.dart';
import 'package:cohms/domain/usecases/get_departmenr_usecase.dart';
import 'package:cohms/domain/usecases/get_user_data_usecase.dart';
import 'package:http/http.dart' as http;


main()async{
  BaseDataSource baseDataSource=DataSource();
  BaseDeviceRepository baseDeviceRepository=DeviceRepository(baseDataSource);
var result=await GetContractUseCase(baseDeviceRepository).call();
print(result);
}