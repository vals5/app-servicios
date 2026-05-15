// lib/screens/confirmation.dart
// Cliente ve el presupuesto del profesional y decide aceptar

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class AcceptBudgetScreen extends StatelessWidget {
  const AcceptBudgetScreen({super.key});

  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClientProvider>();
    final p = provider.presupuestoActivo ?? provider.presupuestoPendiente;

    if (p == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estás a un paso de reservar el horario',
                      style: TextStyle(color: Colors.black54, fontFamily: 'Poppins')),
                  const SizedBox(height: 12),
                  _profesionalCard(p),
                  const SizedBox(height: 14),
                  _presupuestoCard(p),
                  const SizedBox(height: 14),
                  _senaCard(p),
                  const SizedBox(height: 30),
                  _botonConfirmar(context, provider, p),
                  const SizedBox(height: 20),
                ],
              ),
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

  Widget _profesionalCard(p) {
    return _card(child: Row(children: [
      CircleAvatar(radius: 28, backgroundColor: Colors.grey[200],
          child: const Icon(Icons.person, size: 28, color: Colors.grey)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ← antes: 'Leonardo Giménez' hardcodeado
        Text(p.profesionalNombre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
        Text(p.profesionalCategoria,
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.star, color: _amarillo, size: 18),
          const SizedBox(width: 4),
          // ← antes: '4.8 (23 trab.)' hardcodeado
          Text('${p.profesionalRating} (${p.profesionalTrabajos} trab.)',
              style: const TextStyle(fontFamily: 'Poppins')),
        ]),
      ])),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: _amarillo, foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        child: const Text('Ver perfil', style: TextStyle(fontFamily: 'Poppins')),
      ),
    ]));
  }

  Widget _presupuestoCard(p) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.calendar_today, size: 20),
        SizedBox(width: 8),
        Text('Presupuesto estimado', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      ]),
      const SizedBox(height: 10),
      // ← antes: '$12.000 – $18.000' hardcodeado
      Text('Min: \$${p.precioMin.toStringAsFixed(0)} – Máx: \$${p.precioMax.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 16, fontFamily: 'Poppins')),
      const SizedBox(height: 10),
      // ← antes: '12 de marzo - 15:30 hs' hardcodeado
      Text('${p.diaVisita} - ${p.franjaHoraria}',
          style: const TextStyle(fontSize: 16, fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      const Text('El precio final se confirma al terminar el trabajo.',
          style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
    ]));
  }

  Widget _senaCard(p) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.verified, color: Colors.green),
        SizedBox(width: 8),
        Text('Seña para confirmar', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      ]),
      const SizedBox(height: 12),
      // ← antes: '$1.800' hardcodeado
      Text('Seña: \$${p.montoSena.toStringAsFixed(0)} (15% del mínimo)',
          style: const TextStyle(color: Colors.green, fontSize: 15, fontFamily: 'Poppins')),
      const SizedBox(height: 10),
      const Text('La seña confirma la visita del profesional.',
          style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
      const SizedBox(height: 10),
      const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.info_outline, size: 16),
        SizedBox(width: 6),
        Expanded(child: Text(
          'Si el profesional llega y el cliente no está, la seña se paga al profesional.',
          style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
        )),
      ]),
    ]));
  }

  Widget _botonConfirmar(BuildContext context, ClientProvider provider, p) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _amarillo, foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () {
            // ← acepta el presupuesto en el provider
            provider.aceptarPresupuesto(p.id);
            Navigator.pushNamed(context, '/budget');
          },
          child: const Text('Pagar seña y confirmar visita',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
        ),
      ),
      const SizedBox(height: 8),
      const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.lock, size: 14, color: Colors.black54),
        SizedBox(width: 4),
        Text('Pago seguro. Recibís comprobante en la app.',
            style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
      ]),
    ]);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: child,
    );
  }
}