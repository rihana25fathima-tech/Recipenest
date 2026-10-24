import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
 
  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });
}