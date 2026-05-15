// lib/screens/fp_confirmed.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class FPConfirmedScreen extends StatefulWidget {
  const FPConfirmedScreen({super.key});

  @override
  State<FPConfirmedScreen> createState() => _FPConfirmedScreenState();
}

class _FPConfirmedScreenState extends State<FPConfirmedScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  int _rating = 0;
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ← lee el último trabajo del historial del cliente
    final historial = context.watch<ClientProvider>().historial;
    final ultimoTrabajo = historial.isNotEmpty ? historial.last : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          // ─── APP BAR ───
          Container(
            color: _darkBg,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16, right: 16, bottom: 16,
            ),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 24),
            ]),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Icon(Icons.check_circle, color: Colors.green, size: 70),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Pago completado!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ahora podés calificar al profesional',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  // ─── CARD CALIFICACIÓN ───
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8, offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32, backgroundColor: Colors.grey[200],
                          child: const Icon(Icons.person, size: 32, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        // ← antes: 'Leonardo Giménez' hardcodeado
                        Text(
                          ultimoTrabajo?.profesionalNombre ?? 'Profesional',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          ultimoTrabajo?.profesionalCategoria ?? '',
                          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black54),
                        ),
                        const SizedBox(height: 16),

                        // ─── ESTRELLAS ───
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) => GestureDetector(
                            onTap: () => setState(() => _rating = i + 1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                i < _rating ? Icons.star : Icons.star_border,
                                size: 36,
                                color: _amarillo,
                              ),
                            ),
                          )),
                        ),
                        const SizedBox(height: 16),

                        // ─── COMENTARIO ───
                        TextField(
                          controller: _comment,
                          maxLines: 3,
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Dejá tu comentario (opcional)',
                            hintStyle: const TextStyle(
                              color: Colors.black38, fontFamily: 'Poppins',
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // ─── BOTÓN ENVIAR ───
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _amarillo,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        // En etapa 3: guardar calificación en Supabase
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home-cliente', (_) => false);
                      },
                      child: const Text(
                        'Enviar calificación',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, '/home-cliente', (_) => false),
                    child: const Text(
                      'Omitir por ahora',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}