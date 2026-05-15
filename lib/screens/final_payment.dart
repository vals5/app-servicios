// lib/screens/final_payment.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class FinalPaymentScreen extends StatelessWidget {
  const FinalPaymentScreen({super.key});

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

    final saldo = p.precioFinal != null
        ? p.precioFinal! - p.montoSena
        : p.saldoPendiente;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                  Icon(Icons.circle, size: 10, color: Colors.orange),
                  SizedBox(width: 6),
                  Text('Pendiente de pago',
                      style: TextStyle(color: Colors.orange, fontFamily: 'Poppins')),
                ]),
                const SizedBox(height: 14),
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    CircleAvatar(radius: 26, backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.grey)),
                    const SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p.profesionalNombre,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                      Text(p.profesionalCategoria,
                          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
                      Text('${p.diaVisita} – ${p.franjaHoraria}',
                          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
                    ]),
                  ]),
                  const SizedBox(height: 12),
                  const Text('Trabajo realizado:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  Text(p.descripcion, style: const TextStyle(fontFamily: 'Poppins')),
                  const Divider(height: 24),
                  _row('Total del trabajo',
                      '\$${(p.precioFinal ?? p.precioMax).toStringAsFixed(0)}'),
                  _row('Seña pagada', '\$${p.montoSena.toStringAsFixed(0)}'),
                  const SizedBox(height: 6),
                  _rowBold('Saldo a pagar', '\$${saldo.toStringAsFixed(0)}'),
                  const SizedBox(height: 6),
                  const Text('Este es el importe final del trabajo realizado.',
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins')),
                ])),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _amarillo, foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      provider.confirmarPagoFinal(p.id);
                      Navigator.pushNamed(context, '/fp-confirmed');
                    },
                    child: const Text('Pagar con Mercado Pago',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
                  ),
                ),
                const SizedBox(height: 14),
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('CBU: 0000003100000001234567', style: TextStyle(fontFamily: 'Poppins')),
                  Text('Alias: RAPI.ARREGLO', style: TextStyle(fontFamily: 'Poppins')),
                  Text('Banco Nación', style: TextStyle(fontFamily: 'Poppins')),
                ])),
                const SizedBox(height: 14),
                _card(child: Row(children: const [
                  Icon(Icons.payments, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(child: Text(
                    'Pagar en efectivo al profesional.\nEl profesional registrará el pago una vez recibido.',
                    style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                  )),
                ])),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/disagree'),
                    child: const Text('No estoy de acuerdo',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),
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
        const Expanded(child: Center(child: Text('Trabajo finalizado',
            style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')))),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _row(String l, String r) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontFamily: 'Poppins')),
      Text(r, style: const TextStyle(fontFamily: 'Poppins')),
    ]);
  }

  Widget _rowBold(String l, String r) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      Text(r, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
    ]);
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}