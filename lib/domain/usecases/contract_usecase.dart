
import '../entities/contract_entities.dart';
import '../repository/device_repository.dart';

class GetContractUseCase{
  BaseDeviceRepository baseDeviceRepository;
  GetContractUseCase(this.baseDeviceRepository);
  Future<List<Contract>>call(){
    return baseDeviceRepository.getContractData();
  }
}