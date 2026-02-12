import 'package:flutter/material.dart';
import 'payment_confirmed.dart';

class PayDepositScreen extends StatelessWidget {
  const PayDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagar seña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _payCard(
              title: 'Pagar con Mercado Pago',
              buttonText: 'Pagar ahora',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaymentConfirmedScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _payCard(
              title: 'Transferencia bancaria',
              buttonText: 'Subir comprobante',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _payCard({
    required String title,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D400),
              ),
              onPressed: onTap,
              child:
                  Text(buttonText, style: const TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
