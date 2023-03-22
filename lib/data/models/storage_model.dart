

import '../../domain/entities/store_entities.dart';

class StorageModel extends Store {
  StorageModel({required super.deviceName,
    required super.deviceCode,
    required super.image,
    required super.date,
    required super.report});

  factory StorageModel.fromJson(Map<String, dynamic>json)=>
      StorageModel(deviceName: json["device_name"],
          deviceCode: json["dev_code"],
          image:json["image"],
          date: json["date"],
          report:json["report"]);
}
