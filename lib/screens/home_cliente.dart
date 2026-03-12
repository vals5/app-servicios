import 'package:flutter/material.dart';
import '../widgets/category_card.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ─────────────── BOTTOM BAR ───────────────
      bottomNavigationBar: Container(
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
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Trabajos'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─────────────── HEADER ───────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Hola, Valen 👋',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.notifications_none),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '¿Qué necesitás arreglar hoy?',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // ─────────────── CATEGORÍAS ───────────────
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
                children: const [
                  CategoryCard(icon: Icons.plumbing, label: 'Plomero'),
                  CategoryCard(icon: Icons.flash_on, label: 'Electricista'),
                  CategoryCard(
                      icon: Icons.local_fire_department, label: 'Gasista'),
                  CategoryCard(icon: Icons.vpn_key, label: 'Generales'),
                  CategoryCard(icon: Icons.ac_unit, label: 'AC'),
                  CategoryCard(icon: Icons.format_paint, label: 'Pintor'),
                ],
              ),

              const SizedBox(height: 28),

              // ---------------- PRÓXIMO EN RAPIARREGLO ----------------
              const Text(
                '🚀 Próximo en RAPIARREGLO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _promoCard(
                      icon: Icons.assignment,
                      title: 'Proyectos grandes',
                      text: 'Coordiná trabajos importantes.',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _promoCard(
                      icon: Icons.location_on,
                      title: 'Seguimiento',
                      text: 'Seguimiento en tiempo real.',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ─────────── CONSEJOS ÚTILES ───────────
              const Text(
                '💡 Consejos útiles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              _tipCard(
                'Electricidad',
                'Evitá sobrecargar enchufes y zapatillas.',
              ),
              _tipCard(
                'Gas',
                'Revisá las conexiones una vez al año.',
              ),
              _tipCard(
                'Aire acondicionado',
                'Limpiá los filtros cada 30 días.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────── CARD PRÓXIMO ───────────────
  Widget _promoCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Colors.orange),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── CARD CONSEJO ───────────────
  Widget _tipCard(String title, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7D400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.lightbulb_outline),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
