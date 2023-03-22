

import '../../domain/entities/departments_entities.dart';

class DepartmentModel extends Department {
  DepartmentModel(
      {required super.departmentName, required super.departmentCode});

  factory DepartmentModel.fromJSON(Map<String, dynamic> json) =>
      DepartmentModel(
          departmentCode: json["department code"],
          departmentName: json["department name"]);
}
