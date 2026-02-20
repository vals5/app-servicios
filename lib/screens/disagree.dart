import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DisagreeScreen extends StatefulWidget {
  const DisagreeScreen({super.key});

  @override
  State<DisagreeScreen> createState() => _DisagreeScreenState();
}

class _DisagreeScreenState extends State<DisagreeScreen> {
  final TextEditingController controller = TextEditingController();
  final List<File> images = [];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null && images.length < 3) {
      setState(() => images.add(File(file.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            const Text(
              "No estoy de acuerdo",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Color(0xff1a1a1a),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Contanos por qué no estás de acuerdo con el importe final.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Card de Info de Pago
            _infoCard(),

            const SizedBox(height: 16),

            // Card de Protección (Escudo)
            _protectionCard(),

            const SizedBox(height: 24),
            const Text(
              "Motivo del reclamo",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Comentá el problema...",
                hintStyle: const TextStyle(color: Colors.black38),
                filled: true,
                fillColor: const Color(0xffececec).withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Fotos
            GestureDetector(
              onTap: pickImage,
              child: Row(
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    "Adjuntar fotos (opcional)",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const Spacer(),
                  const Icon(Icons.add, size: 28),
                ],
              ),
            ),
            if (images.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                children: images
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(e,
                              width: 60, height: 60, fit: BoxFit.cover),
                        ))
                    .toList(),
              ),
            ],

            const SizedBox(height: 30),

            // Botón Enviar
            _yellowButton("Enviar reclamo", () {
              // Acción
            }),

            const SizedBox(height: 10),

            // Botón Cancelar
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(
                  color: Color(0xff6c63ff),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffededed).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Leonardo Giménez",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            "Total del trabajo: \$12.000",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 4),
          Text(
            "Saldo a pagar: \$10.200",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _protectionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffededed).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, color: Colors.black45, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "Para evitar incomodidades con el profesional, podés reailizar el pago con tranquilidad. RapiArreglo resolverá el caso y te acompañará con la gestión correspondiente.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _yellowButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfffbc02d), // Amarillo intenso
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
