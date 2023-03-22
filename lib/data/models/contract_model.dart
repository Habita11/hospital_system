

import '../../domain/entities/contract_entities.dart';

class ContractModel extends Contract {
  ContractModel({required super.companyId,
    required super.companyName,
    required super.duration,
    required super.instDate,
    required super.mainCondition});

  factory ContractModel.fromJson(Map<String, dynamic>json)=>
      ContractModel(companyId: json["companyid"],
          companyName: json["companyname"],
          duration: json["duration"],
          instDate: json["instdate"],
          mainCondition: json["maincondition"]);
}
