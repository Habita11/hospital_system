

import '../../domain/entities/stock_entities.dart';

class StockModel extends Stock {
  StockModel({required super.partId,
    required super.partName,
    required super.departmentCode,
    required super.departmentName,
    required super.partNum});

  factory StockModel.fromJSON(Map<String, dynamic>json)=>
      StockModel(partId: json["part id"],
          partName: json["part name"],
          departmentCode:json["department code"],
          departmentName: json["department name"],
          partNum: json["part number"]);
}
