import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtok_technologies_mt/providers/auth_provider.dart';
import 'package:newtok_technologies_mt/providers/location_provider.dart';
import 'package:newtok_technologies_mt/providers/user_report_provider.dart';
import 'package:newtok_technologies_mt/providers/weather_provider.dart';
import 'package:newtok_technologies_mt/ui/admin/admin_dashboard/admin_dashboard_screen.dart';
import 'package:newtok_technologies_mt/ui/shared/login/login_screen.dart';
import 'package:newtok_technologies_mt/ui/shared/splash/splash_screen.dart';
import 'package:newtok_technologies_mt/ui/user/user_dashboard/user_dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => UserReportProvider()),
      ],
      child: MaterialApp(
        title: 'Your App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/admin': (context) => const AdminDashboardScreen(),
          '/user': (context) => const UserDashboardScreen(),
        },
      ),
    );
  }
}
