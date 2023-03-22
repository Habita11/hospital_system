



import '../entities/store_entities.dart';
import '../repository/device_repository.dart';

class StorageUseCase{
  BaseDeviceRepository baseDeviceRepository;
  StorageUseCase(this.baseDeviceRepository);
  Future<List<Store>> call(){
    return baseDeviceRepository.getStorageData();
  }
}