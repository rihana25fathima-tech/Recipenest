import 'package:hive_flutter/hive_flutter.dart';
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
    for (int i = 0; i < bbox.length; i++) {
      final user = bbox.getAt(i)!;

      if (user.email.toLowerCase().trim() == email.trim().toLowerCase() &&
          user.password == password) {
        // Other users logout
        for (int j = 0; j < bbox.length; j++) {
          final otherUser = bbox.getAt(j)!;
          otherUser.isLoggedIn = false;
          await bbox.putAt(j, otherUser);
        }
      // Current user login
        user.isLoggedIn = true;
        await bbox.putAt(i, user);

        return true;
      }
    }
    return false;
  }
}
