// lib/screens/budget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClientProvider>();
    final p = provider.presupuestoActivo;

    if (p == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                _profesionalInfo(p),
                const SizedBox(height: 14),
                _presupuesto(p),
                const SizedBox(height: 14),
                _senaInfo(p),
                const SizedBox(height: 30),
                _pagarButton(context, provider, p),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _darkBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16, bottom: 16,
      ),
      child: Row(children: [
        GestureDetector(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white)),
        const Expanded(child: Center(child: Text('Confirmar visita',
            style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')))),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _profesionalInfo(p) {
    return _card(child: Row(children: [
      CircleAvatar(radius: 28, backgroundColor: Colors.grey[200],
          child: const Icon(Icons.person, size: 28, color: Colors.grey)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.profesionalNombre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        Text(p.profesionalCategoria,
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
        Text('⭐ ${p.profesionalRating} (${p.profesionalTrabajos} trabajos)',
            style: const TextStyle(fontFamily: 'Poppins')),
      ])),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: _amarillo, foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: const Text('Ver perfil', style: TextStyle(fontFamily: 'Poppins')),
      ),
    ]));
  }

  Widget _presupuesto(p) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Presupuesto estimado',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      Text('Min: \$${p.precioMin.toStringAsFixed(0)} – Máx: \$${p.precioMax.toStringAsFixed(0)}',
          style: const TextStyle(fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      Text('${p.diaVisita} - ${p.franjaHoraria}',
          style: const TextStyle(fontFamily: 'Poppins')),
      const SizedBox(height: 4),
      const Text('El precio final se confirma al terminar el trabajo.',
          style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
    ]));
  }

  Widget _senaInfo(p) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Seña para reservar el turno',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      Text('Seña: \$${p.montoSena.toStringAsFixed(0)} (15% del mínimo)',
          style: const TextStyle(color: Colors.green, fontFamily: 'Poppins')),
      const SizedBox(height: 8),
      const Text('La seña confirma la visita del profesional. Podés cancelar sin costo hasta 3 horas antes.',
          style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
    ]));
  }

  Widget _pagarButton(BuildContext context, ClientProvider provider, p) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _amarillo, foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/payment'),
          child: const Text('Pagar seña y confirmar visita',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        ),
      ),
      const SizedBox(height: 8),
      const Text('Pago seguro. Recibís comprobante en la app.',
          style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
    ]);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: child,
    );
  }
}