import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_next/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //box edkkum

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
        // SharedPreferences
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', user.email);
        return true;
      }
    }
    return false;
  }

  // Reset Password
  Future<bool> resetPassword(String email, String newPassword) async {
    for (int i = 0; i < bbox.length; i++) {
      final user = bbox.getAt(i)!;
      if (user.email.toLowerCase().trim() == email.trim().toLowerCase()) {
        user.password = newPassword;
        await bbox.putAt(i, user);
        return true;
      }
    }
    return false;
  }

  // Check Login Status
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Get Logged In User Email
  Future<String?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  // Logout
  Future<void> logout() async {
    // Update Hive login status
    for (int i = 0; i < bbox.length; i++) {
      final user = bbox.getAt(i)!;
      if (user.isLoggedIn) {
        user.isLoggedIn = false;
        await bbox.putAt(i, user);
      }
    }
    // Clear SharedPreferences session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
  }
}
