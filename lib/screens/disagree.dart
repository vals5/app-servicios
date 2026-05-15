import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class DisagreeScreen extends StatefulWidget {
  const DisagreeScreen({super.key});

  @override
  State<DisagreeScreen> createState() => _DisagreeScreenState();
}

class _DisagreeScreenState extends State<DisagreeScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClientProvider>();
    final p = provider.presupuestoActivo;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                const Text('No estoy de acuerdo',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, fontFamily: 'Poppins')),
                const SizedBox(height: 12),
                const Text('Contanos por qué no estás de acuerdo con el importe final.',
                    style: TextStyle(fontSize: 16, color: Colors.black54, fontFamily: 'Poppins')),
                const SizedBox(height: 24),
                if (p != null) _infoCard(p),
                const SizedBox(height: 16),
                _protectionCard(),
                const SizedBox(height: 24),
                const Text('Motivo del reclamo',
                    style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Poppins')),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  style: const TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    hintText: 'Comentá el problema...',
                    hintStyle: const TextStyle(color: Colors.black38, fontFamily: 'Poppins'),
                    filled: true, fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _amarillo, foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      if (p != null) provider.enviarReclamo(p.id);
                      Navigator.pushNamed(context, '/case-review');
                    },
                    child: const Text('Enviar reclamo',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black54, fontSize: 16, fontFamily: 'Poppins')),
                ),
              ],
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
        const Expanded(child: Center(child: Text('Reclamo',
            style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')))),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _infoCard(p) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.profesionalNombre,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, fontFamily: 'Poppins')),
        const SizedBox(height: 8),
        Text('Total del trabajo: \$${(p.precioFinal ?? p.precioMax).toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 16, fontFamily: 'Poppins')),
        const SizedBox(height: 4),
        Text('Saldo a pagar: \$${p.saldoPendiente.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, fontFamily: 'Poppins')),
      ]),
    );
  }

  Widget _protectionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.shield_outlined, color: Colors.black45, size: 40),
        const SizedBox(width: 16),
        Expanded(child: Text(
          'Para evitar incomodidades con el profesional, podés realizar el pago con tranquilidad. RapiArreglo resolverá el caso y te acompañará con la gestión correspondiente.',
          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7), height: 1.4, fontFamily: 'Poppins'),
        )),
      ]),
    );
  }
}