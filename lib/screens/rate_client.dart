import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/solicitud_provider.dart';

class RateClientScreen extends StatefulWidget {
  const RateClientScreen({super.key});

  @override
  State<RateClientScreen> createState() => _RateClientScreenState();
}

class _RateClientScreenState extends State<RateClientScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  int _estrellas = 5;
  final TextEditingController _comentarioController = TextEditingController();
  bool _reciboAdjunto = false;
  bool _clienteAcuerdo = true;

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ← lee el último trabajo del historial (ya fue cobrado)
    final historial = context.watch<SolicitudProvider>().historial;
    final ultimoTrabajo = historial.isNotEmpty ? historial.last : null;
    final s = ultimoTrabajo?.solicitud;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Text('Calificá al cliente',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  const SizedBox(height: 24),
                  CircleAvatar(radius: 48, backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.person, size: 48, color: Colors.grey)),
                  const SizedBox(height: 14),
                  // ← antes: 'María López' hardcodeado
                  Text(s?.clienteNombre ?? 'Cliente',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.black45),
                      const SizedBox(width: 4),
                      // ← antes: 'Los Alerces' hardcodeado
                      Text(s?.clienteZona ?? '--',
                          style: const TextStyle(fontSize: 13, color: Colors.black45, fontFamily: 'Poppins')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildEstrellas(),
                  const SizedBox(height: 16),
                  const Text('¿Cómo fue tu experiencia?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                  const SizedBox(height: 14),
                  _buildTextareaComentario(),
                  const SizedBox(height: 20),
                  _buildOpcionRecibo(),
                  const SizedBox(height: 10),
                  _buildOpcionAcuerdo(),
                  const SizedBox(height: 6),
                  Text('La comición se calcuai cobre el monto registrado.',
                      style: TextStyle(fontSize: 11, color: Colors.grey[400], fontFamily: 'Poppins')),
                  const SizedBox(height: 24),
                  _buildBotonEnviar(context),
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
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 12, left: 16, right: 16, bottom: 16),
      child: Row(children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: Colors.white)),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _buildEstrellas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) => GestureDetector(
        onTap: () => setState(() => _estrellas = i + 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(i < _estrellas ? Icons.star : Icons.star_border, color: _amarillo, size: 44),
        ),
      )),
    );
  }

  Widget _buildTextareaComentario() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.black12)),
      child: TextField(
        controller: _comentarioController, maxLines: 4,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        decoration: const InputDecoration(border: InputBorder.none,
            hintText: 'Escribí un comentario (opcional)',
            hintStyle: TextStyle(color: Colors.black38, fontSize: 14, fontFamily: 'Poppins'),
            contentPadding: EdgeInsets.all(16)),
      ),
    );
  }

  Widget _buildOpcionRecibo() {
    return GestureDetector(
      onTap: () => setState(() => _reciboAdjunto = !_reciboAdjunto),
      child: Row(children: [
        Container(width: 28, height: 28,
            decoration: BoxDecoration(color: Colors.pink[50], borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.receipt_outlined, size: 16, color: Colors.pink[300])),
        const SizedBox(width: 10),
        const Text('Recibo como respaldo (opcional)', style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
      ]),
    );
  }

  Widget _buildOpcionAcuerdo() {
    return Row(children: [
      GestureDetector(
        onTap: () => setState(() => _clienteAcuerdo = !_clienteAcuerdo),
        child: Container(width: 28, height: 28,
            decoration: BoxDecoration(color: _clienteAcuerdo ? Colors.green[50] : Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.check, size: 18, color: _clienteAcuerdo ? Colors.green : Colors.grey)),
      ),
      const SizedBox(width: 10),
      const Expanded(child: Text('El cliente está de acuerdo con este monto', style: TextStyle(fontSize: 13, fontFamily: 'Poppins'))),
    ]);
  }

  Widget _buildBotonEnviar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // ← navega al home y limpia el stack
        onPressed: () => Navigator.pushReplacementNamed(context, '/home-profesional'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: const Text('Enviar calificación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))]),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) { if (i == 0) Navigator.pushReplacementNamed(context, '/home-profesional'); },
        selectedItemColor: _amarillo, unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.white, elevation: 0,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Solicitudes'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Ganancias'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}