import 'package:flutter/material.dart';

class FPConfirmedScreen extends StatefulWidget {
  const FPConfirmedScreen({super.key});

  @override
  State<FPConfirmedScreen> createState() => _FPConfirmedScreenState();
}

class _FPConfirmedScreenState extends State<FPConfirmedScreen> {
  int rating = 0;
  final TextEditingController comment = TextEditingController();

  Widget star(int index) {
    return IconButton(
      onPressed: () => setState(() => rating = index + 1),
      icon: Icon(
        Icons.star,
        size: 34,
        color: index < rating ? Colors.amber : Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.check_circle, color: Colors.green, size: 70),
              const SizedBox(height: 12),
              const Text(
                '¡Pago completado!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text('Ahora podés calificar al profesional'),
              const SizedBox(height: 20),
              _card(
                child: Column(
                  children: [
                    const Text('Leonardo Giménez',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Electricista'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) => star(i)),
                    ),
                    TextField(
                      controller: comment,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Dejá un comentario (opcional)',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: const Color(0xFFF7D400),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home-cliente', (_) => false);
                },
                child: const Text('Enviar calificación'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home-cliente', (_) => false);
                },
                child: const Text('Omitir por ahora'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
