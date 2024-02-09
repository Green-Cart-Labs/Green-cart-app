import 'dart:math';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cart/community/community.dart';
import 'package:green_cart/dashboard/dashboard.dart';
import 'package:green_cart/login/login.dart';
import 'package:green_cart/profile/profile.dart';
import 'package:green_cart/scan/productDetails.dart';
import 'package:green_cart/scan/scan.dart';
import '../theme.dart';

// enum AppRoute {
//   community,
//   scan,
//   dashboard,
//   productDetails,
//   profile,
// }

// final List<(String, Widget)> pageBothList = [
//   ('community', Community()),
//   ('scan', Scan()),
//   ('dashboard', Dashboard()),
//   ('product', ProductDetails()),
//   ('profile', Profile())
// ];

final List<String> pageStringList = [
  'community',
  'scan',
  'dashboard',
  'community',
  'profile',
  'product',
];

final List<Widget> pageList = [
  const Community(),
  const Scan(),
  const Dashboard(),
  const Community(),
  const Profile(),
  const ProductDetails(),
  // const ProductDetails(),

];

class AuthGlobalWidget extends StatefulWidget {
  // const AuthGlobalWidget({Key? key}) : super(key: key);
  // final Widget child;
  final String myChildType;
  const AuthGlobalWidget({super.key, required this.myChildType});

  @override
  _AuthGlobalWidgetState createState() => _AuthGlobalWidgetState();
}

class _AuthGlobalWidgetState extends State<AuthGlobalWidget> {
  late int _selectedIndex;
  late PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = pageStringList.indexOf(widget.myChildType);
    print("index: $_selectedIndex");
    pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("index: $_selectedIndex , $index");
    if(index == 5){
      pageList.elementAt(_selectedIndex);
    // pageController.jumpTo(ProductDetails());
    } else {
      pageController.jumpToPage(index);
    }
  }

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
            child: PageView(
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
          unselectedItemColor: const Color.fromARGB(255, 171, 202, 13),
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.group, size: 30),
              activeIcon: Icon(CupertinoIcons.group_solid, size: 30),
              label: 'Community',
              // backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.qrcode),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compost),
              label: 'Tracker',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill),
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
