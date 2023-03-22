
import '../entities/suppliers_entities.dart';
import '../repository/device_repository.dart';

class GetSuppliersDataUseCase{

  BaseDeviceRepository baseDeviceRepository;
  GetSuppliersDataUseCase(this.baseDeviceRepository);
  Future<List<Supplier>> call(){
    return baseDeviceRepository.getSuppliersData();
  }
}