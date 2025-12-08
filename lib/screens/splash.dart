import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5A623),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.bolt,
                  size: 90,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Rapi Arreglo",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
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
                  Icon(Icons.gas_meter, color: Colors.blue, size: 28),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
