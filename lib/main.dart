import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/user-type.dart';
import 'screens/profile-progress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: "Poppins",
        scaffoldBackgroundColor: const Color(0xFFF7D400),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/user-type': (context) => const UserTypeScreen(),
        '/complete-profile': (context) => const CompleteProfileScreen(),
      },
    );
  }
}
