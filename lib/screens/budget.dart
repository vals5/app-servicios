import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Confirmar visita',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _profesionalInfo(),
            const SizedBox(height: 14),
            _presupuesto(),
            const SizedBox(height: 14),
            _senaInfo(),
            const SizedBox(height: 30),
            _pagarButton(context),
          ],
        ),
      ),
    );
  }

  Widget _profesionalInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Leonardo Giménez',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Electricista'),
                Text('⭐ 4.8 (23 trabajos)'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
            ),
            child: const Text('Ver perfil'),
          )
        ],
      ),
    );
  }

  Widget _presupuesto() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Presupuesto estimado',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text('Min: \$12.000 – Máx: \$18.000'),
          SizedBox(height: 4),
          Text(
            'El precio final se confirma al terminar el trabajo.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _senaInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Seña para reservar el turno',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            'Seña: \$1.800 (15% del mínimo)',
            style: TextStyle(color: Colors.green),
          ),
          SizedBox(height: 8),
          Text(
            'La seña confirma la visita del profesional.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _pagarButton(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/payment');
          },
          child: const Text(
            'Pagar seña y confirmar visita',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pago seguro. Recibís comprobante en la app.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 3),
        )
      ],
    );
  }
}
