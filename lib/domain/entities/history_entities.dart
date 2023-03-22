import 'package:equatable/equatable.dart';

class History extends Equatable{
  String? departmentName;
  String? companyName;
  String? startDate;
  String? protectiveMaintenance;
  String? correctiveMaintenance;
  String? status;
  String? departmentCode;
  String? companyId;
  String? deviceName;
  String? userId;
  History({
    required this.userId,
    required this.departmentName,
    required this.companyName,
    required this.deviceName,
    required this.status,
    required this.companyId,
    required this.correctiveMaintenance,
    required this.departmentCode,
    required this.protectiveMaintenance,
    required this.startDate
  });
  @override

  List<Object?> get props =>[
    status,
    companyId,
    departmentCode,
    protectiveMaintenance,
    correctiveMaintenance,
    startDate,
    deviceName,
    departmentName,
    companyName,
    userId
  ];


}