import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7D400),

      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, color: Colors.black, size: 50),
                  SizedBox(width: 8),
                  Text(
                    "RAPI ARREGLO",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.build, color: Colors.green, size: 28),
                    SizedBox(width: 10),
                    Icon(Icons.plumbing, color: Colors.red, size: 28),
                    SizedBox(width: 10),
                    Icon(Icons.power, color: Colors.orange, size: 28),
                    SizedBox(width: 10),
                    Icon(Icons.brush, color: Colors.blue, size: 28),
                    SizedBox(width: 10),
                    Icon(Icons.gas_meter, color: Colors.green, size: 28),
                    SizedBox(width: 10),
                    Icon(Icons.water_drop, color: Colors.red, size: 28),
                    SizedBox(width: 10),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}