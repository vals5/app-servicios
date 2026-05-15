import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/solicitud_provider.dart';

class FinishedJobScreen extends StatefulWidget {
  const FinishedJobScreen({super.key});

  @override
  State<FinishedJobScreen> createState() => _FinishedJobScreenState();
}

class _FinishedJobScreenState extends State<FinishedJobScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  late TextEditingController _montoController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ← inicializa el monto con el precio del presupuesto, antes era '25.000' fijo
    final trabajo = context.read<SolicitudProvider>().trabajoActivo;
    _montoController = TextEditingController(
      text: trabajo?.solicitud.precio?.toStringAsFixed(0) ?? '0',
    );
  }

  @override
  void dispose() {
    _montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trabajo = context.watch<SolicitudProvider>().trabajoActivo;

    if (trabajo == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
      return const SizedBox.shrink();
    }

    final s = trabajo.solicitud;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Center(child: _buildSuccessHeader()),
                  const SizedBox(height: 20),
                  _buildCardResumen(s, trabajo),
                  const SizedBox(height: 20),
                  const Text('Cobrar al cliente:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  const SizedBox(height: 12),
                  _buildInputMonto(),
                  const SizedBox(height: 8),
                  Text('Este monto será enviado al cliente para realizar el pago.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'Poppins')),
                  const SizedBox(height: 20),
                  _buildBotonEnviar(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _buildChatInput(),
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

  Widget _buildSuccessHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(10, (i) {
                final colors = [Colors.green, _amarillo, Colors.orange, Colors.blue];
                final offsets = [
                  const Offset(-70, -20), const Offset(70, -20), const Offset(-50, 20), const Offset(50, 20),
                  const Offset(-80, 5), const Offset(80, 5), const Offset(-30, -35), const Offset(30, -35),
                  const Offset(-60, 30), const Offset(60, 30),
                ];
                return Transform.translate(offset: offsets[i],
                  child: Container(width: 9, height: 9,
                      decoration: BoxDecoration(color: colors[i % colors.length], borderRadius: BorderRadius.circular(2))));
              }),
              Container(width: 60, height: 60,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 34)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('Trabajo finalizado', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins'), textAlign: TextAlign.center),
        const Text('correctamente', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins'), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildCardResumen(s, trabajo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(radius: 22, backgroundColor: Colors.grey[200], child: const Icon(Icons.person, color: Colors.grey)),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ← antes: 'María López' hardcodeado
              Text(s.clienteNombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins')),
              Row(children: [
                const Icon(Icons.star, color: _amarillo, size: 15),
                const SizedBox(width: 4),
                Text('${s.clienteRating} (${s.clienteTrabajos} trabajos)',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ]),
            ]),
          ]),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Colors.black12),
          const SizedBox(height: 14),
          Row(children: [
            const Text('💰', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            // ← antes: '$25.000' hardcodeado
            Text('Monto: \$${s.precio?.toStringAsFixed(0) ?? '--'}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.access_time_outlined, size: 18, color: Colors.black54),
            const SizedBox(width: 10),
            // ← antes: '01:12:45' hardcodeado
            Text('Tiempo de trabajo: ${trabajo.duracionFormateada}',
                style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.black87)),
          ]),
        ],
      ),
    );
  }

  Widget _buildInputMonto() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black12)),
      child: Row(children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text('\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54, fontFamily: 'Poppins'))),
        Container(width: 1, height: 40, color: Colors.black12),
        Expanded(child: TextField(
          controller: _montoController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 14)),
        )),
      ]),
    );
  }

  Widget _buildBotonEnviar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/received'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: const Text('Enviar monto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(children: [
        const Icon(Icons.mic_none, color: Colors.black45, size: 22), const SizedBox(width: 8),
        Expanded(child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(24)),
          child: const Text('Escribir mensaje...', style: TextStyle(color: Colors.black38, fontSize: 14, fontFamily: 'Poppins')),
        )),
        const SizedBox(width: 8),
        const Icon(Icons.camera_alt_outlined, color: Colors.black45, size: 22),
        const SizedBox(width: 8),
        const Icon(Icons.send_outlined, color: Colors.black45, size: 22),
      ]),
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