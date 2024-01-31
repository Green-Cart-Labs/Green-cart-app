import 'package:go_router/go_router.dart';
import 'package:green_cart/community/community.dart';
import 'package:green_cart/profile/profile.dart';
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
      builder: (context, state) => (const AuthGlobalWidget(child: Dashboard())),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => (const AuthGlobalWidget(child: Profile())),
    ),
    GoRoute(
      name: 'community',
      path: '/community',
      builder: (context, state) => (const AuthGlobalWidget(child: Community())),
    ),
  ],
);
