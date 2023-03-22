

import '../../domain/entities/suppliers_entities.dart';

class SupplierModel extends Supplier {
  SupplierModel({required super.companyName,
    required super.deviceCode,
    required super.deviceName,
    required super.partPrice,
    required super.partName,
    required super.partId,
    required super.companyId});

  factory SupplierModel.fromJson(Map<String, dynamic> json)=>
      SupplierModel(
          companyName: json["company name"],
          deviceCode: json["device code"],
          deviceName: json["device name"],
          partPrice: json["part price"],
          partName: json["part name"],
          partId: json["part id"],
          companyId: json["company id"]);
}
