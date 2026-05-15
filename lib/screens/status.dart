// lib/screens/status.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';
import 'chat.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/final-payment');
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ClientProvider>().presupuestoActivo;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(context, p),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (p != null)
                  _card(child: Row(children: [
                    CircleAvatar(radius: 28, backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.grey)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p.profesionalNombre,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                      Text(p.profesionalCategoria,
                          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54)),
                      Text('⭐ ${p.profesionalRating} (${p.profesionalTrabajos} trab.)',
                          style: const TextStyle(fontFamily: 'Poppins')),
                    ])),
                  ])),
                const SizedBox(height: 16),
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Estado actual:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  SizedBox(height: 12),
                  _StepItem('Profesional confirmado', Icons.check_circle, Colors.green),
                  _StepItem('En camino', Icons.directions_car, Colors.grey),
                  _StepItem('En la puerta', Icons.home, Colors.grey),
                  _StepItem('Trabajo finalizado', Icons.done_all, Colors.grey),
                ])),
                const SizedBox(height: 16),
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    p != null ? '${p.profesionalNombre} está en la puerta' : 'Profesional en la puerta',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p != null ? '${p.profesionalNombre} ya llegó al domicilio.' : 'El profesional ya llegó.',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Text('Ahí salgo', style: TextStyle(fontFamily: 'Poppins')),
                    )),
                    const SizedBox(width: 10),
                    Expanded(child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Text('Dame unos minutos',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
                    )),
                  ]),
                ])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _amarillo, foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ChatScreen())),
                child: const Text('Ir al chat',
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, p) {
    return Container(
      color: _darkBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16, bottom: 16,
      ),
      child: Row(children: [
        GestureDetector(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white)),
        Expanded(child: Center(child: Text(
          p?.profesionalCategoria ?? 'Seguimiento',
          style: const TextStyle(color: _amarillo, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ))),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: child,
    );
  }
}

class _StepItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _StepItem(this.text, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontFamily: 'Poppins')),
      ]),
    );
  }
}