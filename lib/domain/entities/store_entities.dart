import 'package:equatable/equatable.dart';

class Store extends Equatable{
  String deviceCode;
  String deviceName;
  String image;
  String date;
  String report;
  Store({
    required this.deviceName,
    required this.deviceCode,
    required this.image,
    required this.date,
    required this.report
});

  @override

  List<Object?> get props => [
    deviceCode,
    deviceName,
    date,
    image,
    report
  ];
}