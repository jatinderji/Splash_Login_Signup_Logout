import 'package:flutter/material.dart';
import 'package:sign_in_signup_lougout_app/models/users_model.dart';
import 'package:sign_in_signup_lougout_app/pages/login_page.dart';
import 'package:sign_in_signup_lougout_app/repositories/auth_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationRepo authenticationRepo = AuthenticationRepo();
  UsersModel users = UsersModel(
      page: 0,
      perPage: 0,
      total: 0,
      totalPages: 0,
      data: [],
      support: Support(url: '', text: ''));
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    users = await authenticationRepo.getAllUsers();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                //
                final isLoggedOut = await authenticationRepo.logout();
                if (isLoggedOut && mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }

                //
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: isLoaded
                  ? ListView.builder(
                      itemCount: users.data.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                            '${users.data[index].firstName} ${users.data[index].lastName}'),
                        subtitle: Text(users.data[index].email),
                      ),
                    )
                  : const CircularProgressIndicator()),
        ),
      ),
    );
  }
}
