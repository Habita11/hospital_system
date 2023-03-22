

import '../entities/user_entities.dart';
import '../repository/device_repository.dart';

class GetUserDataUseCase{
  BaseDeviceRepository baseDeviceRepository;
  GetUserDataUseCase(this.baseDeviceRepository);
  Future<List<User>> call(){
    return baseDeviceRepository.getUserData();
  }
}