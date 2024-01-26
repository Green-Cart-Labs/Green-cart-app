import 'package:flutter/material.dart';

class AuthGlobalWidget extends StatefulWidget {
  const AuthGlobalWidget({Key? key}) : super(key: key);

  @override
  _AuthGlobalWidgetState createState() => _AuthGlobalWidgetState();
}

class _AuthGlobalWidgetState extends State<AuthGlobalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF909E47), Color(0xFFF6F7ED), Color(0xFF909E47)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
