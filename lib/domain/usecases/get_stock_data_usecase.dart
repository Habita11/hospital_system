
import '../entities/stock_entities.dart';
import '../repository/device_repository.dart';

class GetStockDataUseCase{
  BaseDeviceRepository baseDeviceRepository;
  GetStockDataUseCase(this.baseDeviceRepository);
  Future<List<Stock>> call(){
    return baseDeviceRepository.getStockData();
  }
}