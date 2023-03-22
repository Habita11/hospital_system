import 'package:equatable/equatable.dart';

class Department extends Equatable{
  String departmentName;
  String departmentCode;
  Department({
    required this.departmentName,
    required this.departmentCode,
});

  @override
  List<Object?> get props => [
    departmentName,
    departmentCode
  ];


}