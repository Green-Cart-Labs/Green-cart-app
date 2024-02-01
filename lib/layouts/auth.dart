import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cart/community/community.dart';
import 'package:green_cart/dashboard/dashboard.dart';
import 'package:green_cart/login/login.dart';
import 'package:green_cart/profile/profile.dart';
import '../theme.dart';

class AuthGlobalWidget extends StatefulWidget {
  // const AuthGlobalWidget({Key? key}) : super(key: key);
  final Widget child;
  const AuthGlobalWidget({super.key, required this.child});

  @override
  _AuthGlobalWidgetState createState() => _AuthGlobalWidgetState();
}

class _AuthGlobalWidgetState extends State<AuthGlobalWidget> {
  int _selectedIndex = 2;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    pageController.jumpToPage(index);
    // !pageController.keepPage;
  }

  List<Widget> pageList = [
    const Community(),
    const Profile(),
    const Dashboard(),
    const Profile(),
    const Profile(),
  ];

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
            child:
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              // scrollDirection: ,
              children: [
                pageList.elementAt(_selectedIndex),
              ],
            ),
            // widget.child,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF295B3E),
          unselectedItemColor: const Color(0xFF909E47),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Community',
              // backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compost),
              label: 'Tracker',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
