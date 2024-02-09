import 'package:flutter/material.dart';


class GradientContainer extends StatelessWidget {
  const GradientContainer({required this.child, super.key});
  final Widget child;

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
      child: child
    );
  }
}