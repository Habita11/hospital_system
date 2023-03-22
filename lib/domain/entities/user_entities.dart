import 'package:equatable/equatable.dart';

class User extends Equatable{
  String userName;
  String userID;
  String departmentCode;
  String email;
  String phone;
  String password;
  User({
    required this.departmentCode,
    required this.email,
    required this.password,
    required this.phone,
    required this.userID,
    required this.userName,

});

  @override
  List<Object?> get props => [
    departmentCode,
    email,
    phone,
    userName,
    userName,
    password
  ];
}