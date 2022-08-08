import 'package:dhiigplus/screens/profile.dart';
import 'package:flutter/material.dart';
import '../auth/login.dart';
import '../auth/singup.dart';
import '../auth/splash.dart';
import '../screens/root.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => const Splash());
      case '/login':
        if (args is String) {
          return MaterialPageRoute(builder: (context) => const Login());
        }
        return _errorRoute();
      case '/signUp':
        if (args is String) {
          return MaterialPageRoute(builder: (context) => const SignUp());
        }
        return _errorRoute();
      case '/verify':
        if (args is String) {
          return MaterialPageRoute(builder: (context) => const SignUp());
        }
        return _errorRoute();
      case '/home':
        if (args is String) {
          return MaterialPageRoute(builder: (context) => const Root());
        }
        return _errorRoute();
      case '/profile':
        if (args is String) {
          return MaterialPageRoute(builder: (context) => const ProfilePage());
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
