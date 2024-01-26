import 'dart:math';
import 'package:flutter/material.dart';

import '../theme.dart';

class AuthGlobalWidget extends StatefulWidget {
  // const AuthGlobalWidget({Key? key}) : super(key: key);
  final Widget child;
  const AuthGlobalWidget({super.key, required this.child});

  @override
  _AuthGlobalWidgetState createState() => _AuthGlobalWidgetState();
}

class _AuthGlobalWidgetState extends State<AuthGlobalWidget> {

  @override
  Widget build(BuildContext context) {
    log(10);
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF909E47), Color(0xFFF6F7ED), Color(0xFF909E47)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// <<<<<<< dev/janvi
// home: const MyHomePage(title: 'Bloom'),
// );
// }
// }
//
// class MyHomePage extends StatefulWidget {
// const MyHomePage({super.key, required this.title});
//
// final String title;
//
// @override
// State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
// void _incrementCounter() {
//   setState(() {
//     // This call to setState tells the Flutter framework that something has
//     // changed in this State, which causes it to rerun the build method below
//     // so that the display can reflect the updated values. If we changed
//     // _counter without calling setState(), then the build method would not be
//     // called again, and so nothing would appear to happen.
//     _counter++;
//   });
// }

// @override
// Widget build(BuildContext context) {
//
// double screenWidth = MediaQuery.of(context).size.width;
// double screenHeight = MediaQuery.of(context).size.height;
//
// return Scaffold(
// body: Container(
// width: screenWidth,
// height: screenHeight,
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// colors: [
// Color(0xFF909E47),
// Color(0xFFF6F7ED),
// Color(0xFF909E47)],
// // stops: [0.0, 0.25, 0.95],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// ),
// child: const Padding(
// padding: EdgeInsets.all(20.0),
// child: Dashboard(),
// ),
// ),
// =======
