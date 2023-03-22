import 'package:equatable/equatable.dart';

class Stock extends Equatable{
  String partId;
  String partNum;
  String partName;
  String departmentCode;
  String departmentName;
  Stock({
    required this.partId,
    required this.partName,
    required this.departmentCode,
    required this.departmentName,
    required this.partNum
});

  @override

  List<Object?> get props => [
    partName,
    partId,
    partNum,
    departmentName,
    departmentCode
  ];

}