
import '../entities/departments_entities.dart';
import '../repository/device_repository.dart';

class GetDepartmentUseCase {
  BaseDeviceRepository baseDeviceRepository;
  GetDepartmentUseCase(this.baseDeviceRepository);
  Future<List<Department>> call()async{
    return await baseDeviceRepository.getDepartmentData();
  }
}