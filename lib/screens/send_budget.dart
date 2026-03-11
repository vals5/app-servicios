import 'package:flutter/material.dart';

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

  final List<String> _dias = [
    'Hoy',
    'Mañana',
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  final List<String> _horarios = [
    '8:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
  ];

  @override
  void dispose() {
    _costoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          // ─── APP BAR OSCURO ───
          _buildAppBar(context),

          // ─── CONTENIDO ───
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card cliente
                  _buildCardCliente(),
                  const SizedBox(height: 16),

                  // Card problema reportado
                  _buildCardProblema(),
                  const SizedBox(height: 20),

                  // Costo del trabajo
                  _buildCampoLabel('Costo del trabajo (ARS)'),
                  const SizedBox(height: 8),
                  _buildInputCosto(),
                  const SizedBox(height: 20),

                  // Día de visita
                  _buildCampoLabel('Día de visita'),
                  const SizedBox(height: 8),
                  _buildSelectorDia(context),
                  const SizedBox(height: 20),

                  // Franja horaria
                  _buildCampoLabel('Franja horaria de visita'),
                  const SizedBox(height: 8),
                  _buildSelectorHorario(context),
                  const SizedBox(height: 20),

                  // Notas informativas
                  _buildNotas(),
                  const SizedBox(height: 24),

                  // Botón Presupuestar
                  _buildBotonPresupuestar(context),
                  const SizedBox(height: 12),

                  // Botón Rechazar
                  _buildBotonRechazar(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── APP BAR ───────────────
  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _darkBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 16,
      ),
    );
  }

  // ─────────────── CARD CLIENTE ───────────────
  Widget _buildCardCliente() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, size: 30, color: Colors.grey),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'María López',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.star, color: _amarillo, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.8 (7 trabajos)',
                      style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 15),
                    SizedBox(width: 5),
                    Text(
                      'Cliente verificado',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined,
                        size: 15, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(
                      'Zona: Godoy Cruz',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── CARD PROBLEMA ───────────────
  Widget _buildCardProblema() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.receipt_long_outlined,
                  size: 18, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                'Problema reportado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Descripción con borde izquierdo naranja
          Container(
            padding: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
            child: const Text(
              'Se cortó la luz en la cocina y saltó la térmica.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.access_time_outlined, size: 15, color: Colors.black45),
              SizedBox(width: 6),
              Text(
                'Tiempo estimado de trabajo: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '30-60 min',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────── LABEL CAMPO ───────────────
  Widget _buildCampoLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    );
  }

  // ─────────────── INPUT COSTO ───────────────
  Widget _buildInputCosto() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _amarillo),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '\$',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black54,
              ),
            ),
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
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── SELECTOR DÍA ───────────────
  Widget _buildSelectorDia(BuildContext context) {
    return GestureDetector(
      onTap: () => _mostrarBottomSheetDia(context),
      child: _selectorWidget(
        texto: _diaSeleccionado ?? 'Seleccionar día',
        seleccionado: _diaSeleccionado != null,
      ),
    );
  }

  // ─────────────── SELECTOR HORARIO ───────────────
  Widget _buildSelectorHorario(BuildContext context) {
    return GestureDetector(
      onTap: () => _mostrarBottomSheetHorario(context),
      child: _selectorWidget(
        texto: _horarioSeleccionado ?? 'Seleccionar horario',
        seleccionado: _horarioSeleccionado != null,
      ),
    );
  }

  Widget _selectorWidget({required String texto, required bool seleccionado}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: seleccionado ? _amarillo : Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            texto,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: seleccionado ? Colors.black : Colors.black38,
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black45),
        ],
      ),
    );
  }

  // ─────────────── NOTAS INFORMATIVAS ───────────────
  Widget _buildNotas() {
    return Column(
      children: [
        _notaItem(
          icon: Icons.lock_outline,
          iconColor: Colors.orange,
          texto: 'Sólo el cliente podrá ver tu presupuesto.',
        ),
        const SizedBox(height: 8),
        _notaItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          textoNormal: ' suelen pagar de forma rápida.',
          textoBold: 'Clientes verificados',
        ),
      ],
    );
  }

  Widget _notaItem({
    required IconData icon,
    required Color iconColor,
    String? texto,
    String? textoBold,
    String? textoNormal,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: texto != null
              ? Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                )
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      TextSpan(
                        text: textoBold,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(text: textoNormal),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  // ─────────────── BOTÓN PRESUPUESTAR ───────────────
  Widget _buildBotonPresupuestar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_costoController.text.isEmpty ||
              _diaSeleccionado == null ||
              _horarioSeleccionado == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Completá todos los campos para presupuestar.',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          Navigator.pushNamed(context, '/accepted');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _amarillo,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Enviar presupuesto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // ─────────────── BOTÓN RECHAZAR ───────────────
  Widget _buildBotonRechazar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black26),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Rechazar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // ─────────────── BOTTOM SHEET DÍA ───────────────
  void _mostrarBottomSheetDia(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _bottomSheetLista(
        titulo: 'Seleccionar día',
        items: _dias,
        onSelect: (val) => setState(() => _diaSeleccionado = val),
      ),
    );
  }

  // ─────────────── BOTTOM SHEET HORARIO ───────────────
  void _mostrarBottomSheetHorario(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _bottomSheetLista(
        titulo: 'Franja horaria',
        items: _horarios,
        onSelect: (val) => setState(() => _horarioSeleccionado = val),
      ),
    );
  }

  Widget _bottomSheetLista({
    required String titulo,
    required List<String> items,
    required void Function(String) onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => ListTile(
              title: Text(item, style: const TextStyle(fontFamily: 'Poppins')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                onSelect(item);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── BOTTOM NAV ───────────────
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home-profesional');
          }
        },
        selectedItemColor: _amarillo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontSize: 11),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: 'Solicitudes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded), label: 'Agenda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Ganancias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
