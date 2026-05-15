import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/solicitud_provider.dart';

class SendBudgetScreen extends StatefulWidget {
  const SendBudgetScreen({super.key});

  @override
  State<SendBudgetScreen> createState() => _SendBudgetScreenState();
}

class _SendBudgetScreenState extends State<SendBudgetScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  final TextEditingController _costoController = TextEditingController();
  String? _diaSeleccionado;
  String? _horarioSeleccionado;

  final List<String> _dias = ['Hoy', 'Mañana', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  final List<String> _horarios = ['8:00 - 10:00', '10:00 - 12:00', '12:00 - 14:00', '14:00 - 16:00', '16:00 - 18:00', '18:00 - 20:00'];

  @override
  void dispose() {
    _costoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ← lee la solicitud seleccionada del provider
    final provider = context.watch<SolicitudProvider>();
    final s = provider.solicitudSeleccionada;

    if (s == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ← pasa la solicitud a los widgets
                  _buildCardCliente(s),
                  const SizedBox(height: 16),
                  _buildCardProblema(s),
                  const SizedBox(height: 20),
                  _buildCampoLabel('Costo del trabajo (ARS)'),
                  const SizedBox(height: 8),
                  _buildInputCosto(),
                  const SizedBox(height: 20),
                  _buildCampoLabel('Día de visita'),
                  const SizedBox(height: 8),
                  _buildSelectorDia(context),
                  const SizedBox(height: 20),
                  _buildCampoLabel('Franja horaria de visita'),
                  const SizedBox(height: 8),
                  _buildSelectorHorario(context),
                  const SizedBox(height: 20),
                  _buildNotas(),
                  const SizedBox(height: 24),
                  _buildBotonPresupuestar(context, provider, s.id),
                  const SizedBox(height: 12),
                  _buildBotonRechazar(context, provider, s.id),
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text('Presupuestar',
                  style: TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  // ← antes: nombre y datos hardcodeados
  Widget _buildCardCliente(s) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 28, backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 30, color: Colors.grey)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.clienteNombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.star, color: _amarillo, size: 16),
                  const SizedBox(width: 4),
                  Text('${s.clienteRating} (${s.clienteTrabajos} trabajos)',
                      style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
                ]),
                const SizedBox(height: 6),
                if (s.clienteVerificado)
                  Row(children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 15),
                    SizedBox(width: 5),
                    Text('Cliente verificado', style: TextStyle(fontSize: 13, color: Colors.green, fontFamily: 'Poppins')),
                  ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined, size: 15, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text('Zona: ${s.clienteZona}',
                      style: const TextStyle(fontSize: 13, color: Colors.black54, fontFamily: 'Poppins')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ← antes: descripción hardcodeada
  Widget _buildCardProblema(s) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.receipt_long_outlined, size: 18, color: Colors.black87),
            SizedBox(width: 8),
            Text('Problema reportado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins')),
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.orange, width: 3))),
            child: Text(s.descripcion,
                style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', height: 1.4)),
          ),
          const SizedBox(height: 12),
          Row(children: const [
            Icon(Icons.access_time_outlined, size: 15, color: Colors.black45),
            SizedBox(width: 6),
            Text('Tiempo estimado de trabajo: ',
                style: TextStyle(fontSize: 12, color: Colors.black45, fontFamily: 'Poppins')),
            Text('30-60 min', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          ]),
        ],
      ),
    );
  }

  Widget _buildCampoLabel(String label) {
    return Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins'));
  }

  Widget _buildInputCosto() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _amarillo),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text('\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.black54)),
          ),
          Container(width: 1, height: 40, color: _amarillo),
          Expanded(
            child: TextField(
              controller: _costoController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 15),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Ingresa el costo final del trabajo',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 14, fontFamily: 'Poppins'),
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorDia(BuildContext context) {
    return GestureDetector(
      onTap: () => _mostrarBottomSheetDia(context),
      child: _selectorWidget(texto: _diaSeleccionado ?? 'Seleccionar día', seleccionado: _diaSeleccionado != null),
    );
  }

  Widget _buildSelectorHorario(BuildContext context) {
    return GestureDetector(
      onTap: () => _mostrarBottomSheetHorario(context),
      child: _selectorWidget(texto: _horarioSeleccionado ?? 'Seleccionar horario', seleccionado: _horarioSeleccionado != null),
    );
  }

  Widget _selectorWidget({required String texto, required bool seleccionado}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: seleccionado ? _amarillo : Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(texto, style: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: seleccionado ? Colors.black : Colors.black38)),
          const Icon(Icons.chevron_right, color: Colors.black45),
        ],
      ),
    );
  }

  Widget _buildNotas() {
    return Column(
      children: [
        _notaItem(icon: Icons.lock_outline, iconColor: Colors.orange, texto: 'Sólo el cliente podrá ver tu presupuesto.'),
        const SizedBox(height: 8),
        _notaItem(icon: Icons.check_circle, iconColor: Colors.green, textoNormal: ' suelen pagar de forma rápida.', textoBold: 'Clientes verificados'),
      ],
    );
  }

  Widget _notaItem({required IconData icon, required Color iconColor, String? texto, String? textoBold, String? textoNormal}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: texto != null
              ? Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins'))
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins'),
                    children: [
                      TextSpan(text: textoBold, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      TextSpan(text: textoNormal),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  // ← ahora llama al provider antes de navegar
  Widget _buildBotonPresupuestar(BuildContext context, SolicitudProvider provider, String solicitudId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_costoController.text.isEmpty || _diaSeleccionado == null || _horarioSeleccionado == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Completá todos los campos para presupuestar.', style: TextStyle(fontFamily: 'Poppins')),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          // ← guarda el presupuesto en el provider
          provider.completarPresupuesto(
            id: solicitudId,
            precio: double.tryParse(_costoController.text.replaceAll('.', '').replaceAll(',', '.')) ?? 0,
            diaVisita: _diaSeleccionado!,
            franjaHoraria: _horarioSeleccionado!,
          );
          Navigator.pushNamed(context, '/accepted');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _amarillo, foregroundColor: Colors.black, elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text('Enviar presupuesto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  // ← ahora también rechaza en el provider
  Widget _buildBotonRechazar(BuildContext context, SolicitudProvider provider, String solicitudId) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          provider.rechazarSolicitud(solicitudId);
          Navigator.popUntil(context, NamedRoute('/home-profesional') as RoutePredicate);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black, side: const BorderSide(color: Colors.black26),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text('Rechazar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
    );
  }

  void _mostrarBottomSheetDia(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _bottomSheetLista(titulo: 'Seleccionar día', items: _dias, onSelect: (val) => setState(() => _diaSeleccionado = val)),
    );
  }

  void _mostrarBottomSheetHorario(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _bottomSheetLista(titulo: 'Franja horaria', items: _horarios, onSelect: (val) => setState(() => _horarioSeleccionado = val)),
    );
  }

  Widget _bottomSheetLista({required String titulo, required List<String> items, required void Function(String) onSelect}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
          const SizedBox(height: 12),
          ...items.map((item) => ListTile(
            title: Text(item, style: const TextStyle(fontFamily: 'Poppins')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () { onSelect(item); Navigator.pop(context); },
          )),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))],
      ),
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

// Helper para popUntil con nombre de ruta
class NamedRoute extends Route {
  final String name;
  NamedRoute(this.name);
  @override
  bool get isCurrent => settings.name == name;
}