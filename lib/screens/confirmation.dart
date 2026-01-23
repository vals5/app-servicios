import 'package:flutter/material.dart';

class AcceptBudgetScreen extends StatelessWidget {
  const AcceptBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Confirmar visita',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estás a un paso de reservar el horario',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),
            _profesionalCard(),
            const SizedBox(height: 14),
            _presupuestoCard(),
            const SizedBox(height: 14),
            _senaCard(),
            const SizedBox(height: 90),
          ],
        ),
      ),

      // BOTÓN FIJO ABAJO
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Pagar seña y confirmar visita',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 6),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 14, color: Colors.black54),
                SizedBox(width: 4),
                Text(
                  'Pago seguro. Recibís comprobante en la app.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ----------------- CARDS -----------------

  Widget _profesionalCard() {
    return _card(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('Electricista'),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text('4.8 (23 trab.)'),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
            child: const Text('Ver perfil'),
          ),
        ],
      ),
    );
  }

  Widget _presupuestoCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 20),
              SizedBox(width: 8),
              Text(
                'Presupuesto estimado',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Min: \$12.000 – Máx: \$18.000',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            'El precio final se confirma al terminar el trabajo.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _senaCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.verified, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Seña para confirmar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Seña para reservar el turno',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text(
            'Seña: \$1.800 (15% del mínimo)',
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          SizedBox(height: 10),
          Text(
            'La seña confirma la visita del profesional.',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Si el profesional llega y el cliente no está, la seña se paga al profesional.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------- DECORACIÓN -----------------

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
