import 'package:flutter/material.dart';
import '../views/activationcode_screen.dart';
import '../views/home_screen.dart';
import '../views/onboarding_screen.dart';
import '../views/splash_screen.dart';

class Routes {
  // Define route names as constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String activationCode = '/activationcode';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case activationCode:
        return MaterialPageRoute(builder: (_) => ActivationCodeScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
