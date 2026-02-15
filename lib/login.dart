import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';
import 'user_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

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
                "Login",
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
                child: const Text('No account? Register by clicking here',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
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
                  child: const Text('LOGIN',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                  onPressed: () {
                    bool isValid = registeredUsers.any((user) =>
                        user.email == _loginEmailController.text &&
                        user.password == _loginPasswordController.text);

                    if (isValid) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(email: _loginEmailController.text)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Invalid Email or Password")),
                      );
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
