import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  String? partId;
  String? partName;
  String? partPrice;
  String? deviceCode;
  String? companyId;
  String? deviceName;
  String? companyName;

  Supplier({
    required this.companyName,
    required this.deviceCode,
    required this.deviceName,
    required this.partPrice,
    required this.partName,
    required this.partId,
    required this.companyId
});

  @override
  List<Object?> get props => [
        partId,
        partName,
        partPrice,
        deviceName,
        deviceCode,
        companyName,
        companyId
      ];
}
