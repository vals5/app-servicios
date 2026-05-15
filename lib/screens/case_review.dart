// lib/screens/case_review.dart
// Usada por AMBOS flujos: cliente (después de disagree) y profesional (si aplica)
// Lee del ClienteProvider para mostrar datos del presupuesto en disputa

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class CaseReviewScreen extends StatelessWidget {
  const CaseReviewScreen({super.key});

  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ClientProvider>().presupuestoActivo;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
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
              const Expanded(
                child: Center(
                  child: Text(
                    'Caso en revisión',
                    style: TextStyle(
                      color: _amarillo, fontSize: 20,
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                    ),
                  ),
                ),
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

                  // ─── ICONO ───
                  Container(
                    width: 70, height: 70,
                    decoration: const BoxDecoration(
                      color: _amarillo, shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.search, size: 34),
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'Caso en revisión',
                    style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Estamos analizando tu reclamo.\nTe notificaremos cuando haya una resolución.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // ─── CARD ───
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 12),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(children: [
                          CircleAvatar(
                            radius: 28, backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ← antes: 'Leonardo Giménez' hardcodeado
                                Text(
                                  p?.profesionalNombre ?? 'Profesional',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  p?.profesionalCategoria ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins', color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3E0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Caso en revisión',
                                    style: TextStyle(
                                      fontSize: 12, color: Colors.orange, fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 16),

                        Row(children: [
                          const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                          const SizedBox(width: 8),
                          // ← antes: 'Jue 15:30 — 16:30' hardcodeado
                          Text(
                            p != null ? '${p.diaVisita} – ${p.franjaHoraria}' : '--',
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ]),
                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _amarillo, foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Reprogramar visita',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, '/home-cliente', (_) => false),
                          child: const Text(
                            'Cerrar',
                            style: TextStyle(fontFamily: 'Poppins', color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}