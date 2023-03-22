import 'package:cohms/domain/repository/device_repository.dart';

import '../entities/history_entities.dart';

class HistoryUseCase{
  BaseDeviceRepository baseDeviceRepository;
  HistoryUseCase(this.baseDeviceRepository);
  Future<List<History>> call(){
    return baseDeviceRepository.getHistoryData();

  }
}