import 'package:equatable/equatable.dart';

class Device extends Equatable {
  String deviceName;
  String deviceCode;
  String department;
  String roomNumber;
  String? imageURL;
  String departmentCode;


  Device(
      {required this.deviceName,
      required this.deviceCode,
      required this.department,
      required this.departmentCode,
      required this.roomNumber,
      required this.imageURL,
  });

  @override
  List<Object?> get props =>
      [
        deviceName,
        deviceCode,
        department,
        departmentCode,
        roomNumber,
        imageURL,

      ];
}
