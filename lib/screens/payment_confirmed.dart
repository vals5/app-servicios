// lib/screens/payment_confirmed.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';
import 'chat.dart';

class PaymentConfirmedScreen extends StatefulWidget {
  const PaymentConfirmedScreen({super.key});

  @override
  State<PaymentConfirmedScreen> createState() => _PaymentConfirmedScreenState();
}

class _PaymentConfirmedScreenState extends State<PaymentConfirmedScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/status');
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ClientProvider>().presupuestoActivo;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: _darkBg,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16, right: 16, bottom: 16,
            ),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white)),
              const SizedBox(width: 24),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const SizedBox(height: 40),
                const Icon(Icons.check_circle, size: 70, color: Colors.green),
                const SizedBox(height: 16),
                const Text('¡Pago confirmado!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                const Text('Tu visita quedó reservada correctamente.',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
                const SizedBox(height: 24),
                if (p != null)
                  _card(child: Column(children: [
                    Text(p.profesionalNombre,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                    const SizedBox(height: 4),
                    Text(p.profesionalCategoria,
                        style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
                    const SizedBox(height: 4),
                    Text('⭐ ${p.profesionalRating} (${p.profesionalTrabajos} trabajos)',
                        style: const TextStyle(fontFamily: 'Poppins')),
                    const SizedBox(height: 4),
                    Text('Seña pagada: \$${p.montoSena.toStringAsFixed(0)}',
                        style: const TextStyle(fontFamily: 'Poppins', color: Colors.green)),
                    const SizedBox(height: 4),
                    Text('${p.diaVisita} - ${p.franjaHoraria}',
                        style: const TextStyle(fontFamily: 'Poppins')),
                  ])),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: _amarillo),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _amarillo, foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ChatScreen())),
                    child: const Text('Ir al chat',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: child,
    );
  }
}