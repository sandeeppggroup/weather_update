import '../imports.dart';

class Routes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String admin = '/admin';
  static const String user = '/user';

  Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    '/login': (context) => const LoginScreen(),
    '/admin': (context) => const AdminDashboardScreen(),
    '/user': (context) => const UserDashboardScreen(),
  };
}
