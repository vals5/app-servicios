import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/solicitud_provider.dart';

class ArrivedScreen extends StatefulWidget {
  const ArrivedScreen({super.key});

  @override
  State<ArrivedScreen> createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SolicitudProvider>();
    final trabajo = provider.trabajoActivo;

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
                children: [
                  const SizedBox(height: 8),
                  const Text('Estás en el domicilio del cliente',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  _buildToolboxIllustration(),
                  const SizedBox(height: 24),
                  // ← llama al provider
                  _buildBotonIniciar(context, provider),
                  const SizedBox(height: 12),
                  _buildBotonPausa(context, provider, trabajo),
                  const SizedBox(height: 16),
                  _buildConsejo(),
                  const SizedBox(height: 16),
                  // ← datos del cliente desde el trabajo activo
                  _buildCardCliente(s),
                  const SizedBox(height: 16),
                  _buildBotonFinalizado(context, provider),
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
      child: Row(
        children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: Colors.white)),
          const Expanded(child: Center(child: Text('Iniciar el trabajo',
              style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')))),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildToolboxIllustration() {
    return Container(
      width: 140, height: 140,
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(70)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(8, (i) {
            final colors = [_amarillo, Colors.green, Colors.blue, Colors.orange];
            final offsets = [
              const Offset(-50, -40), const Offset(50, -40), const Offset(-55, 10), const Offset(55, 10),
              const Offset(-35, 45), const Offset(35, 45), const Offset(-20, -50), const Offset(20, -50),
            ];
            return Transform.translate(offset: offsets[i],
              child: Container(width: 8, height: 8,
                  decoration: BoxDecoration(color: colors[i % colors.length], borderRadius: BorderRadius.circular(2))));
          }),
          const Text('🧰', style: TextStyle(fontSize: 64)),
        ],
      ),
    );
  }

  // ← llama a provider.iniciarTrabajo()
  Widget _buildBotonIniciar(BuildContext context, SolicitudProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => provider.iniciarTrabajo(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: const Text('Iniciar trabajo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  // ← llama a provider.pausarTrabajo()
  Widget _buildBotonPausa(BuildContext context, SolicitudProvider provider, trabajo) {
    final enPausa = trabajo.estado.name == 'enPausa';
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => provider.pausarTrabajo(),
        style: ElevatedButton.styleFrom(backgroundColor: _amarillo, foregroundColor: Colors.black, elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: Text(enPausa ? 'Reanudar trabajo' : 'Trabajo en pausa',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  Widget _buildConsejo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.black12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('💡', style: TextStyle(fontSize: 18)),
          SizedBox(width: 10),
          Expanded(child: Text('Consejo: Podrás finalizar el trabajo cuando hayas terminado y recibas el pago',
              style: TextStyle(fontSize: 13, fontFamily: 'Poppins', color: Colors.black87))),
        ],
      ),
    );
  }

  // ← antes: 'María López', '$25.000' hardcodeados
  Widget _buildCardCliente(s) {
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
              Text(s.clienteNombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins')),
              Row(children: [
                const Icon(Icons.star, color: _amarillo, size: 15),
                const SizedBox(width: 4),
                Text('${s.clienteRating} (${s.clienteTrabajos} trabajos)',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ]),
            ]),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.location_on, color: Colors.green, size: 16),
            const SizedBox(width: 6),
            Expanded(child: Text(s.direccion ?? s.clienteZona,
                style: const TextStyle(fontSize: 13, fontFamily: 'Poppins'))),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Container(width: 18, height: 18,
                decoration: BoxDecoration(color: _amarillo, borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.wallet, size: 12, color: Colors.black)),
            const SizedBox(width: 8),
            Text('Cobrarás \$${s.precio?.toStringAsFixed(0) ?? '--'} al finalizar el trabajo',
                style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
          ]),
        ],
      ),
    );
  }

  // ← llama a provider.finalizarTrabajo() antes de navegar
  Widget _buildBotonFinalizado(BuildContext context, SolicitudProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          provider.finalizarTrabajo();
          Navigator.pushNamed(context, '/finished');
        },
        style: OutlinedButton.styleFrom(foregroundColor: Colors.black45, side: const BorderSide(color: Colors.black12),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: const Text('Trabajo finalizado',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'Poppins', color: Colors.black45)),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(children: [
        const Icon(Icons.mic_none, color: Colors.black45, size: 22),
        const SizedBox(width: 8),
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