import 'package:flutter/material.dart';
import 'package:sign_in_signup_lougout_app/pages/login_page.dart';
import 'package:sign_in_signup_lougout_app/repositories/auth_repo.dart';
import 'package:sign_in_signup_lougout_app/widgets/common_widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController =
      TextEditingController(text: 'eve.holt@reqres.in');
  TextEditingController passwordController =
      TextEditingController(text: 'pistol');

  bool isPasswordVisible = false;

  AuthenticationRepo authenticationRepo = AuthenticationRepo();

  String msg = '';
  bool isError = false;
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
          child: isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.dashboard_customize,
                          color: Colors.purple,
                          size: size.width / 3,
                        ),
                        const Text(
                          'Register with email and password',
                          style: TextStyle(fontSize: 20),
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
                        msg.isNotEmpty
                            ? Text(
                                msg,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isError ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            final result =
                                await authenticationRepo.registerUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (result == 'success') {
                              msg =
                                  'Registered Successfully. Go ahead and Login';
                            } else {
                              isError = true;
                              msg = result;
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alredy have\'t any account?',
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
                                      builder: (context) => const LoginPage()),
                                );
                                //
                              },
                              child: const Text(
                                'Login',
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
