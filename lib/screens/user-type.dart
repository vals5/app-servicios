import 'package:flutter/material.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7D400),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¿Cómo querés usar la app?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 50),

            _blackMainButton(
              context,
              title: "CLIENTE",
              subtitle: "Solicitar servicios",
            ),

            const SizedBox(height: 20),

            _blackMainButton(
              context,
              title: "PROFESIONAL",
              subtitle: "Ofrecer servicios",
            ),
          ],
        ),
      ),
    );
  }

  Widget _blackMainButton(
    BuildContext context, {
    required String title,
    required String subtitle,
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
        onPressed: () {
          Navigator.pushNamed(context, "/complete-profile");
        },
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFF7D400),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFFF7D400), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
