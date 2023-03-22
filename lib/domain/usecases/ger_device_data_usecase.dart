
import '../entities/device_entities.dart';
import '../repository/device_repository.dart';

class GetDeviceDataUseCase {
   BaseDeviceRepository baseDeviceRepository;
   GetDeviceDataUseCase(this.baseDeviceRepository);

  Future<List<Device>> call()async{
    return await baseDeviceRepository.getDeviceData();
}
}
