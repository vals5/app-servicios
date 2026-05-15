import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/solicitud_provider.dart';

class HomeProfesionalScreen extends StatefulWidget {
  const HomeProfesionalScreen({super.key});

  @override
  State<HomeProfesionalScreen> createState() => _HomeProfesionalScreenState();
}

class _HomeProfesionalScreenState extends State<HomeProfesionalScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/new-request');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ← lee el provider
    final provider = context.watch<SolicitudProvider>();
    final prof = provider.profesional;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Row(
          children: const [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black,
              child: Text("R", style: TextStyle(color: Color(0xFFF7D400), fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10),
            Text("RAPIARREGLO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ← antes: '¡Ya estás operativo!' fijo, ahora saluda con el nombre del profesional
            Text(
              '¡Hola, ${prof.nombre}!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            const Text("Ya podés ver solicitudes y presupuestar trabajos.", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFFF7D400),
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Recibí hasta 2x más solicitudes\ncompletando tu perfil",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // ← antes: 'Perfil 40% completo' hardcodeado
                  Text('Perfil ${prof.porcentajePerfil}% completo'),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      // ← antes: value: 0.4 hardcodeado
                      value: prof.porcentajePerfil / 100,
                      minHeight: 8,
                      backgroundColor: Colors.black12,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFF7D400)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("¿Cómo se trabaja?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _step(1, "Ves solicitudes de clientes"),
            _step(2, "Presupuestás con monto mínimo y máximo"),
            _step(3, "El cliente paga la seña y confirma la visita"),
            _step(4, "Estoy en la puerta"),
            _step(5, "Finalizás el trabajo con fotos + importe final"),
            _step(6, "Ambos se califican"),
            _step(7, "Vos cobrás lo que presupuestás, no se te descuenta"),
            _step(8, "Si vas al domicilio y no está el cliente, la seña la recibís igual"),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFFFE08A), borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("La seña confirma la visita.", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text("El resto del cobro se acuerda al finalizar el trabajo.\nEl cliente paga una pequeña comisión de la plataforma."),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Cuando un cliente te elige, te avisamos por la app.", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Solicitudes"),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: "Trabajos"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }

  Widget _step(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFFF7D400),
            child: Text(number.toString(),
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}