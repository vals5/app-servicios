import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Center(
                child: Text(
                  "R",
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF7D400),
                    height: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // INGRESAR
            _blackButton(
              text: "INGRESAR",
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),

            const SizedBox(height: 20),

            // REGISTRAR
            _blackButton(
              text: "REGISTRARME",
              onPressed: () {
                Navigator.pushNamed(context, '/user-type');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _blackButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFF7D400),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
