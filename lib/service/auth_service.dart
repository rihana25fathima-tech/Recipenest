
import 'package:hive/hive.dart';
import 'package:recipe_next/model/user_model.dart';

class AuthService {
  Box<UserModel> bbox = Hive.box<UserModel>('open');
  //register user
  Future<bool> register(String name, String email, String password) async {
    //Check whether email already exists
    for (UserModel user in bbox.values) {
      if (user.email.toLowerCase() == email.trim().toLowerCase()) {
        return false;
      }
    }
    //create new user
    final newUser = UserModel(
      name: name.trim(),
      email: email.trim(),
      password: password,
    );
    //save user in hive
    await bbox.add(newUser);
    return true;
  }

  //login user
  Future<bool> login(String email, String password) async {
    for (UserModel user in bbox.values) {
      if (user.email.toLowerCase() == email.trim().toLowerCase() &&
          user.password == password) {
        return true;
      }
    }
    return false;
  }
}
