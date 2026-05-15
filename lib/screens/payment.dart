import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
                _serviceInfoCard(p),
                const SizedBox(height: 14),
                _totalCard(p),
                const SizedBox(height: 14),
                _mercadoPagoButton(context, provider, p),
                const SizedBox(height: 14),
                _transferCard(),
              ]),
            ),
          ),
          _buildBotonConfirmar(context, provider, p),
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
        const Expanded(child: Center(child: Text('Pago del servicio',
            style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')))),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _serviceInfoCard(p) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Detalle del turno',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      const SizedBox(height: 10),
      _row('Profesional', p.profesionalNombre),
      _row('Servicio', p.profesionalCategoria),
      _row('Día', p.diaVisita),
      _row('Hora', p.franjaHoraria),
    ]));
  }

  Widget _totalCard(p) {
    return _card(child: Column(children: [
      const Text('Total a pagar',
          style: TextStyle(color: Colors.grey, fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      Text('\$${p.montoSena.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
    ]));
  }

  Widget _mercadoPagoButton(BuildContext context, ClientProvider provider, p) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _amarillo, foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () {
          provider.pagarSena(p.id);
          Navigator.pushNamed(context, '/payment-confirmed');
        },
        child: const Text('Pagar con Mercado Pago',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  Widget _transferCard() {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Transferencia bancaria',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      const SizedBox(height: 8),
      _row('Banco', 'Banco Nación'),
      _row('CBU', '0001234560000000001234'),
      _row('Alias', 'rapi.servicios'),
      _row('Titular', 'Rapi Servicios SAS'),
    ]));
  }

  Widget _buildBotonConfirmar(BuildContext context, ClientProvider provider, p) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _amarillo, foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () {
            provider.pagarSena(p.id);
            Navigator.pushNamed(context, '/payment-confirmed');
          },
          child: const Text('Confirmar pago',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
        ),
      ),
    );
  }

  Widget _row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(left, style: const TextStyle(fontFamily: 'Poppins')),
        Text(right, style: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
      ]),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: child,
    );
  }
}