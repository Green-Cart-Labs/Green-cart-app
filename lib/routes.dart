import 'package:go_router/go_router.dart';
import 'package:green_cart/community/community.dart';
import 'package:green_cart/profile/profile.dart';
import 'package:green_cart/scan/productDetails.dart';
import 'package:green_cart/scan/scan.dart';
import 'dashboard/dashboard.dart';
import 'login/login.dart';
import 'layouts/auth.dart';

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: 'dashboard',
      path: '/',
      builder: (context, state) => (const AuthGlobalWidget(myChildType: 'dashboard',
          // const AuthGlobalWidget(myChildType: 'dashboard',
      )),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => (const AuthGlobalWidget(
        myChildType: 'profile',
      )),
    ),
    GoRoute(
      name: 'community',
      path: '/community',
      builder: (context, state) =>
          (const AuthGlobalWidget(myChildType: 'community')),
    ),
    GoRoute(
      name: 'scan',
      path: '/scan',
      builder: (context, state) =>
          (const AuthGlobalWidget(myChildType: 'scan')),
    ),
    GoRoute(
      name: 'product',
      path: '/product',
      builder: (context, state) =>
          // ProductDetails(),
          (const AuthGlobalWidget(myChildType: 'product')),
    ),
  ],
);
