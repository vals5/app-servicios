import 'package:flutter/material.dart';

class CaseReviewScreen extends StatelessWidget {
  const CaseReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// 🔍 icono amarillo
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xffffcc00),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search, size: 34),
              ),

              const SizedBox(height: 18),

              const Text(
                "Caso en revisión",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Estamos analizando tu reclamo.\nTe notificaremos cuando haya una resolución.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              _card(context),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        children: [
          /// Profesional
          Row(
            children: const [
              CircleAvatar(radius: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Leonardo Giménez",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Electricista"),
                    SizedBox(height: 4),
                    Chip(label: Text("Caso en revisión"))
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          /// fecha
          Row(
            children: const [
              Icon(Icons.calendar_today, size: 18),
              SizedBox(width: 8),
              Text("Jue 15:30 — 16:30"),
            ],
          ),

          const SizedBox(height: 22),

          /// botones
          _yellowButton("Reprogramar visita", () {
            // tu lógica futura
          }),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          )
        ],
      ),
    );
  }

  Widget _yellowButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffffcc00),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
