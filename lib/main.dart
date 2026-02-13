import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/user_type.dart';
import 'screens/complete_profile.dart';
import 'screens/home_cliente.dart';
import 'screens/home_prof.dart';
import 'screens/create_request.dart';
import 'screens/budget.dart';
import 'screens/confirmation.dart';
import 'screens/payment.dart';
import 'screens/payment_confirmed.dart';
import 'screens/status.dart';

import 'providers/profile_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF7D400),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/user-type': (context) => const UserTypeScreen(),
        '/complete-profile': (context) => const CompleteProfileScreen(),
        '/home-cliente': (context) => const HomeClientScreen(),
        '/home-profesional': (context) => const HomeProfesionalScreen(),
        '/create-request': (context) => const CreateRequestScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/confirmation': (context) => const AcceptBudgetScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/payment-confirmed': (context) => const PaymentConfirmedScreen(),
        '/status': (context) => const StatusScreen(),
      },
    );
  }
}
