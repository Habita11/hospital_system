
import '../../domain/entities/device_entities.dart';

class DeviceModel extends Device {
  DeviceModel(
      {required super.deviceName,
      required super.deviceCode,
      required super.department,
      required super.departmentCode,
      required super.roomNumber,
      required super.imageURL,
      });

  factory DeviceModel.fromJSON(Map<String, dynamic> json) => DeviceModel(
      deviceName: json["device name"],
      deviceCode: json["device code"],
      department: json["department name"],
      roomNumber: json["Room number"],
      imageURL: json["URL"],
    departmentCode: json["department code"]
       );
}
