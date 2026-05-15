import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/user_type.dart';
import 'screens/complete_profile.dart';
import 'screens/home_cliente.dart';
import 'screens/home_prof.dart';
import 'screens/new_request.dart';
import 'screens/oportunity.dart';
import 'screens/send_budget.dart';
import 'screens/accepted_budget.dart';
import 'screens/arrived.dart';
import 'screens/finished_job.dart';
import 'screens/payment_received.dart';
import 'screens/rate_client.dart';
import 'screens/confirmation.dart';
import 'screens/budget.dart';
import 'screens/payment.dart';
import 'screens/payment_confirmed.dart';
import 'screens/status.dart';
import 'screens/final_payment.dart';
import 'screens/fp_confirmed.dart';
import 'screens/disagree.dart';
import 'screens/case_review.dart';
import 'screens/create_request.dart';
import 'screens/chat.dart';

import 'providers/profile_provider.dart';
import 'providers/solicitud_provider.dart';
import 'providers/client_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SolicitudProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
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
        // ─── ONBOARDING ───
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/user-type': (context) => const UserTypeScreen(),
        '/complete-profile': (context) => const CompleteProfileScreen(),

        // ─── CLIENTE ───
        '/home-cliente': (context) => const HomeClientScreen(),
        '/confirmation': (context) => const AcceptBudgetScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/payment-confirmed': (context) => const PaymentConfirmedScreen(),
        '/status': (context) => const StatusScreen(),
        '/final-payment': (context) => const FinalPaymentScreen(),
        '/fp-confirmed': (context) => const FPConfirmedScreen(),
        '/disagree': (context) => const DisagreeScreen(),
        '/case-review': (context) => const CaseReviewScreen(),
        '/create-request': (context) => const CreateRequestScreen(),
        '/chat': (context) => const ChatScreen(),

        // ─── PROFESIONAL ───
        '/home-profesional': (context) => const HomeProfesionalScreen(),
        '/new-request': (context) => const NewRequestScreen(),
        '/oportunity': (context) => const OportunityScreen(),
        '/send-budget': (context) => const SendBudgetScreen(),
        '/accepted': (context) => const AcceptedBudgetScreen(),
        '/arrived': (context) => const ArrivedScreen(),
        '/finished': (context) => const FinishedJobScreen(),
        '/received': (context) => const PaymentReceivedScreen(),
        '/rate-client': (context) => const RateClientScreen(),
      },
    );
  }
}