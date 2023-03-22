

import '../../domain/entities/maintenance_entities.dart';

class MaintenanceModel extends Maintenance {
  MaintenanceModel({
    required super.userId,
    required super.departmentName,
    required super.companyName,
    required super.deviceName,
    required super.status,
    required super.companyId,
    required super.correctiveMaintenance,
    required super.departmentCode,
    required super.protectiveMaintenance,
    required super.startDate});

  factory MaintenanceModel.fromJSON(Map<String, dynamic> json)=>
      MaintenanceModel(
          userId: json["user id"],
          departmentName:json["department name"] ,
          companyName: json["company name"],
          deviceName: json["device name"],
          status:json["device status"],
          companyId: json["company id"],
          correctiveMaintenance:json["corrective maintainance"],
          departmentCode: json[ "department code"],
          protectiveMaintenance: json["protective maintainance"],
          startDate: json["device start date "]
      );
}
