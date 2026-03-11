import 'package:flutter/material.dart';

class AcceptedBudgetScreen extends StatelessWidget {
  const AcceptedBudgetScreen({super.key});

  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Confetti + check ──
                  Center(child: _buildSuccessHeader()),
                  const SizedBox(height: 20),

                  // ── Card cliente ──
                  _buildCardCliente(),
                  const SizedBox(height: 16),

                  // ── Detalles trabajo ──
                  _buildCardDetalles(),
                  const SizedBox(height: 12),

                  Center(
                    child: Text(
                      'Escribile ahora para coordinar la visita.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Notas ──
                  _buildNotas(),
                  const SizedBox(height: 24),

                  // ── Botones ──
                  _buildBotonAbriChat(context),
                  const SizedBox(height: 12),
                  _buildBotonVerUbicacion(),
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
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Presupuestar',
                style: TextStyle(
                  color: _amarillo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Confetti visual con Stack
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Confetti dots
              ...List.generate(12, (i) {
                final colors = [
                  Colors.green,
                  _amarillo,
                  Colors.blue,
                  Colors.orange,
                  Colors.red,
                ];
                final positions = [
                  const Offset(-80, -20),
                  const Offset(80, -20),
                  const Offset(-60, 20),
                  const Offset(60, 20),
                  const Offset(-90, 10),
                  const Offset(90, 10),
                  const Offset(-40, -35),
                  const Offset(40, -35),
                  const Offset(-70, 35),
                  const Offset(70, 35),
                  const Offset(-20, -40),
                  const Offset(20, -40),
                ];
                return Transform.translate(
                  offset: positions[i],
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors[i % colors.length],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
              // Círculo verde con check
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'María López',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'aceptó tu presupuesto',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCardCliente() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'María López',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.star, color: _amarillo, size: 15),
                      SizedBox(width: 4),
                      Text(
                        '4.8 (7 trabajos)',
                        style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoRow(Icons.check_circle, 'Cliente verificado', Colors.green),
          const SizedBox(height: 6),
          _infoRow(
              Icons.location_on_outlined, 'Zona: Godoy Cruz', Colors.black54),
          const SizedBox(height: 6),
          _infoRow(Icons.check_circle, 'Trabajo confirmado', Colors.green,
              bold: true, textColor: Colors.green),
        ],
      ),
    );
  }

  Widget _buildCardDetalles() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.monetization_on_outlined, 'Precio: \$25.000',
              Colors.orange),
          const SizedBox(height: 8),
          _infoRow(Icons.calendar_today_outlined, 'Día: Martes 23 de abril',
              Colors.black87),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time_outlined,
                  size: 16, color: Colors.black54),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Horario: 15:00 – 18:00',
                  style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _infoRow(
            Icons.location_on,
            'Dirección aproximada: Barrio Los Alerces, Godoy Cruz',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildNotas() {
    return Column(
      children: [
        _notaItem(Icons.credit_card, Colors.blue,
            'El pago se realiza al finalizar el trabajo.'),
        const SizedBox(height: 8),
        _notaItemRich(Icons.star_border, Colors.orange, 'Responder rápido',
            ' mejora tu calificación.'),
      ],
    );
  }

  Widget _notaItem(IconData icon, Color color, String texto) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            texto,
            style: const TextStyle(fontSize: 13, fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }

  Widget _notaItemRich(IconData icon, Color color, String bold, String normal) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 13, color: Colors.black87, fontFamily: 'Poppins'),
              children: [
                TextSpan(
                  text: bold,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: normal),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String texto, Color iconColor,
      {bool bold = false, Color textColor = Colors.black87}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              color: textColor,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBotonAbriChat(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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
          'Abrir chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildBotonVerUbicacion() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: _amarillo,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black12),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Ver ubicación',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
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
            fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 11),
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
