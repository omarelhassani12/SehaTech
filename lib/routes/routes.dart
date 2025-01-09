import 'package:flutter/material.dart';
import '../views/activationcode_screen.dart';
import '../views/home_screen.dart';
import '../views/onboarding_screen.dart';
import '../views/pages/health_page.dart';
import '../views/pages/journal_page.dart';
import '../views/pages/rating_page.dart';
import '../views/pages/statistics_page.dart';
import '../views/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String activationCode = '/activationcode';
  static const String home = '/home';
  static const String journal = '/journal';
  static const String health = '/health';
  static const String statistics = '/statistics';
  static const String rating = '/rating';

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
      case journal:
        return MaterialPageRoute(builder: (_) => const JournalPage());
      case health:
        return MaterialPageRoute(builder: (_) => const HealthPage());
      case statistics:
        return MaterialPageRoute(builder: (_) => const StatisticsPage());
      case rating:
        return MaterialPageRoute(builder: (_) => const RatingPage());
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
