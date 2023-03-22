import 'package:equatable/equatable.dart';

class Contract extends Equatable{
  String companyId;
  String companyName;
  String duration;
  String instDate;
  String mainCondition;

  Contract({
    required this.companyId,
    required this.companyName,
    required this.duration,
    required this.instDate,
    required this.mainCondition
});

  @override
  List<Object?> get props => [
    companyName,
    companyId,
    duration,
    instDate,
    mainCondition
  ];
}