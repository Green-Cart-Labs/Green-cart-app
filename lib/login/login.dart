import 'package:flutter/material.dart';
import '../layouts/auth.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Global widget overlay
      body: Stack(
        children: [
          const AuthGlobalWidget(),
          // Main content
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login to BLOOM",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('Back to home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
