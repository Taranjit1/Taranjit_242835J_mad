import 'package:flutter/material.dart';
import 'user_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Image(image: AssetImage('images/logo.png')),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(164, 158, 158, 158),
                  hintText: 'Email ID',
                ),
                controller: _loginEmailController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(164, 158, 158, 158),
                  hintText: 'Password',
                ),
                controller: _loginPasswordController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: const Text('Have account? Login by clicking here',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  child: const Text('REGISTER',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                  onPressed: () {
                    String email = _loginEmailController.text;
                    String pass = _loginPasswordController.text;

                    if (email.isNotEmpty && pass.isNotEmpty) {
                      registeredUsers
                          .add(UserDetails(email: email, password: pass));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Registration Successful! Please Login.")),
                      );

                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Details cannot be empty.")));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
