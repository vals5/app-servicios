import 'package:flutter/material.dart';

class OportunityScreen extends StatelessWidget {
  const OportunityScreen({super.key});

  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          // ─── APP BAR OSCURO ───
          _buildAppBar(context),

          // ─── CONTENIDO SCROLLEABLE ───
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner amarillo "NUEVA OPORTUNIDAD"
                  _buildBannerOportunidad(),
                  const SizedBox(height: 16),

                  // Info ganancia + distancia
                  _buildInfoGananciaDistancia(),
                  const SizedBox(height: 6),

                  // Timer urgente
                  _buildTimerUrgente(),
                  const SizedBox(height: 16),

                  // Card cliente
                  _buildCardCliente(),
                  const SizedBox(height: 16),

                  // Card problema
                  _buildCardProblema(),
                  const SizedBox(height: 16),

                  // Fotos + mapa
                  _buildFotos(),
                  const SizedBox(height: 20),

                  // Botones acción
                  _buildBotonesAccion(context),
                  const SizedBox(height: 12),

                  // Nota motivacional
                  Center(
                    child: Text(
                      'Los profesionales mejor calificados responden rápido\ny reciben más trabajos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Rapi Arreglo',
                style: TextStyle(
                  color: _amarillo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 24), // balance
        ],
      ),
    );
  }

  // ─────────────── BANNER OPORTUNIDAD ───────────────
  Widget _buildBannerOportunidad() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: _amarillo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Text('⭐', style: TextStyle(fontSize: 18)),
          SizedBox(width: 8),
          Text(
            'NUEVA OPORTUNIDAD CERCA TUYO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── INFO GANANCIA + DISTANCIA ───────────────
  Widget _buildInfoGananciaDistancia() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('💰', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              const Text(
                'Ganancia estimada',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _amarillo,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Pronaza Urgento',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('🚗', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              const Text(
                'A 5 min — 1,2 km',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _amarillo,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Text(
                      '→ ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                    Text(
                      'Pronaza Urgento',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────── TIMER URGENTE ───────────────
  Widget _buildTimerUrgente() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: Colors.red, size: 18),
          SizedBox(width: 8),
          Text(
            '19:32',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(width: 4),
          Text(
            'para aceptar antes que otro profesional',
            style: TextStyle(
              color: Colors.red,
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
          ),
        ],
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Maria López',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.star, color: _amarillo, size: 16),
              Text(
                '4.8 (7 trabajos)',
                style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 6),
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
          const SizedBox(height: 6),
          const Text(
            'Zona: Godoy Cruz',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontFamily: 'Poppins',
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROBLEMA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1.1,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Se cortó la luz en cocina y saltó la térmica.',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Trabajo estimado por IA:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontFamily: 'Poppins',
            ),
          ),
          const Text(
            'Diagnóstico eléctrico domiciliario.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── FOTOS + MAPA ───────────────
  Widget _buildFotos() {
    return Row(
      children: [
        Expanded(child: _fotoPlaceholder(Icons.electrical_services)),
        const SizedBox(width: 8),
        Expanded(child: _fotoPlaceholder(Icons.build)),
        const SizedBox(width: 8),
        Expanded(child: _mapPlaceholder()),
      ],
    );
  }

  Widget _fotoPlaceholder(IconData icon) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(icon, color: Colors.grey[400], size: 32),
      ),
    );
  }

  Widget _mapPlaceholder() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.map_outlined, color: Colors.green[200], size: 50),
          const Icon(Icons.location_on, color: Colors.red, size: 28),
        ],
      ),
    );
  }

  // ─────────────── BOTONES ACCIÓN ───────────────
  Widget _buildBotonesAccion(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/presupuestar');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _amarillo,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Presupuestar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.black26),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Rechazar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
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
          if (i == 0)
            Navigator.pushReplacementNamed(context, '/home-profesional');
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
