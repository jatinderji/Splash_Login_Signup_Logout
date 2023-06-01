import 'package:flutter/material.dart';
import 'package:sign_in_signup_lougout_app/pages/home_page.dart';
import 'package:sign_in_signup_lougout_app/pages/signup_page.dart';
import 'package:sign_in_signup_lougout_app/repositories/auth_repo.dart';
import 'package:sign_in_signup_lougout_app/widgets/common_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController =
      TextEditingController(text: 'eve.holt@reqres.in');
  TextEditingController passwordController =
      TextEditingController(text: 'cityslicka');
  bool isPasswordVisible = false;

  AuthenticationRepo authenticationRepo = AuthenticationRepo();

  String error = '';
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_person,
                    color: Colors.purple,
                    size: size.width / 3,
                  ),
                  const SizedBox(height: 20),
                  getMyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 20),
                  getMyTextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    hintText: 'Password',
                    icon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(height: 5),
                  error.isNotEmpty
                      ? Text(
                          error,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: !isLoading
                        ? () async {
                            final email = emailController.text;
                            final password = passwordController.text;
                            if (email.isNotEmpty && password.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              //
                              if (await authenticationRepo.loginUser(
                                  email: email, password: password)) {
                                if (mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  );
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                  error = 'Invalid Credentials';
                                });
                              }
                              //
                            } else {
                              setState(() {
                                error = 'Email & Password is required to Login';
                              });
                            }
                          }
                        : null,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have\'t any account?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );
                          //
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height / 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
