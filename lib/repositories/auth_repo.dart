import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_signup_lougout_app/models/users_model.dart';

class AuthenticationRepo {
  static const loginUserURL = 'https://reqres.in/api/login';
  static const registerUserURL = 'https://reqres.in/api/register';
  static const getUsersURL = 'https://reqres.in/api/users?page=1';

  static const isLoggedIn = 'isLoggedIn';
  static const userToken = 'userToken';

  static late SharedPreferences prefs;
  AuthenticationRepo() {
    _initSP();
  }

  _initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

//
  Future<String> registerUser(
      {required String email, required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse(registerUserURL),
          body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        // ok
        return 'success';
      } else {
        return json.decode(response.body)['error'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  //
  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse(loginUserURL),
          body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        // ok
        final token = json.decode(response.body)['token'];
        prefs.setBool(isLoggedIn, true);
        prefs.setString(userToken, token);
        return true;
      } else {
        return json.decode(response.body)['error'];
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    await prefs.clear();
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    if (prefs.getBool(isLoggedIn) ?? false) {
      return true;
    } else {
      return false;
    }
  }

  Future<UsersModel> getAllUsers() async {
    http.Response response = await http.get(Uri.parse(getUsersURL));
    if (response.statusCode == 200) {
      // ok
      return usersModelFromJson(response.body);
    } else {
      return UsersModel(
          page: 0,
          perPage: 0,
          total: 0,
          totalPages: 0,
          data: [],
          support: Support(url: '', text: ''));
    }
  }
}
