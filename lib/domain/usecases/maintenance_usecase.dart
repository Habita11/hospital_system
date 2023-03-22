
import '../entities/maintenance_entities.dart';
import '../repository/device_repository.dart';

class GetMaintenanceDataUseCase {
  BaseDeviceRepository baseDeviceRepository;
  GetMaintenanceDataUseCase(this.baseDeviceRepository);

  Future<List<Maintenance>> call()async{
   return await baseDeviceRepository.getMaintenanceData();
  }

}