import 'package:flutter/material.dart';
import 'package:sign_in_signup_lougout_app/pages/home_page.dart';
import 'package:sign_in_signup_lougout_app/pages/login_page.dart';
import 'package:sign_in_signup_lougout_app/repositories/auth_repo.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  @override
  Widget build(BuildContext context) {
    checkLoggedInAndRespond(context);
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.broadcast_on_personal_rounded,
              size: 100,
              color: Colors.purple,
            ),
            SizedBox(height: 30),
            Text(
              'Signup\nLogin\nView Users\nLogout\nRemember Login',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  void checkLoggedInAndRespond(context) async {
    // wait 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    // check if user is already logged in?
    if (await authenticationRepo.isUserLoggedIn()) {
      navigateTo(context, const HomePage());
    } else {
      navigateTo(context, const LoginPage());
    }

    //
  }

  void navigateTo(context, page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
  //
}
