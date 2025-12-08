import 'package:flutter/material.dart';
import 'screens/signin.dart';
import 'screens/login.dart';

void main() {
  runApp(const RapiArregloApp());
}

class RapiArregloApp extends StatelessWidget {
  const RapiArregloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CrearCuentaScreen(),
      routes: {
        "/crear": (_) => const CrearCuentaScreen(),
        "/login": (_) => const IniciarSesionScreen(),
      },
    );
  }
}
