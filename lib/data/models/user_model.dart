import '../../domain/entities/user_entities.dart';

class UserModel extends User {
  UserModel({required super.departmentCode,
    required super.email,
    required super.password,
    required super.phone,
    required super.userID,
    required super.userName});

  factory UserModel.fromJSON(Map<String, dynamic> json)=>
      UserModel(departmentCode: json["depcode"],
          email: json["email"],
          phone: json["phone"],
          userID: json["userid"],
          userName:json["username"],
          password:json["password"],
      );
}
