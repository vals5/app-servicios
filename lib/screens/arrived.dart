import 'package:flutter/material.dart';

class ArrivedScreen extends StatefulWidget {
  const ArrivedScreen({super.key});

  @override
  State<ArrivedScreen> createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  // ignore: unused_field
  bool _trabajoIniciado = false;
  bool _enPausa = false;
  final TextEditingController _mensajeController = TextEditingController();

  @override
  void dispose() {
    _mensajeController.dispose();
    super.dispose();
  }

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
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Estás en el domicilio del cliente',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Toolbox emoji/ilustración
                  _buildToolboxIllustration(),
                  const SizedBox(height: 24),

                  // Botón Iniciar trabajo
                  _buildBotonIniciar(),
                  const SizedBox(height: 12),

                  // Botón Trabajo en pausa
                  _buildBotonPausa(),
                  const SizedBox(height: 16),

                  // Consejo
                  _buildConsejo(),
                  const SizedBox(height: 16),

                  // Card cliente
                  _buildCardCliente(),
                  const SizedBox(height: 16),

                  // Botón Trabajo finalizado
                  _buildBotonFinalizado(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Chat input fijo abajo
          _buildChatInput(),
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
                'Iniciar el trabajo',
                style: TextStyle(
                  color: _amarillo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildToolboxIllustration() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(70),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti dots
          ...List.generate(8, (i) {
            final colors = [
              _amarillo,
              Colors.green,
              Colors.blue,
              Colors.orange
            ];
            final offsets = [
              const Offset(-50, -40),
              const Offset(50, -40),
              const Offset(-55, 10),
              const Offset(55, 10),
              const Offset(-35, 45),
              const Offset(35, 45),
              const Offset(-20, -50),
              const Offset(20, -50),
            ];
            return Transform.translate(
              offset: offsets[i],
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
          const Text('🧰', style: TextStyle(fontSize: 64)),
        ],
      ),
    );
  }

  Widget _buildBotonIniciar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => setState(() => _trabajoIniciado = true),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Iniciar trabajo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildBotonPausa() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => setState(() => _enPausa = !_enPausa),
        style: ElevatedButton.styleFrom(
          backgroundColor: _amarillo,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Trabajo en pausa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsejo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Consejo: Podrás finalizar el trabajo cuando hayas terminado y recibas el pago',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
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
                  Row(
                    children: [
                      Icon(Icons.star, color: _amarillo, size: 15),
                      SizedBox(width: 4),
                      Text(
                        '8.8 (7 trabajos)',
                        style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.green, size: 16),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Barrio Los Alerces',
                  style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: _amarillo,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.wallet, size: 12, color: Colors.black),
              ),
              const SizedBox(width: 8),
              const Text(
                'Cobrarás \$25.000 al finalizar el trabajo',
                style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBotonFinalizado(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, '/finished'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black45,
          side: const BorderSide(color: Colors.black12),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Trabajo finalizado',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            fontFamily: 'Poppins',
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.mic_none, color: Colors.black45, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Escribir mensaje...',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.camera_alt_outlined,
              color: Colors.black45, size: 22),
          const SizedBox(width: 8),
          const Icon(Icons.send_outlined, color: Colors.black45, size: 22),
        ],
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
