import 'package:go_router/go_router.dart';
import 'dashboard/dashboard.dart';
import 'login/login.dart';
import 'package:green_cart/layouts/auth.dart';

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'dashboard',
      path: '/',
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),
  ],
);
