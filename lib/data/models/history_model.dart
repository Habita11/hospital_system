
import '../../domain/entities/history_entities.dart';

class HistoryModel extends History {
  HistoryModel({
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

  factory HistoryModel.fromJSON(Map<String, dynamic> json)=>
      HistoryModel(
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
