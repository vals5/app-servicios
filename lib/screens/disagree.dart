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
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "No estoy de acuerdo",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Contanos por qué no estás de acuerdo con el importe final.",
            ),
            const SizedBox(height: 20),
            _summaryCard(),
            const SizedBox(height: 20),
            const Text("Motivo del reclamo"),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Comentá el problema...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.camera_alt),
                const SizedBox(width: 8),
                const Text("Adjuntar fotos (opcional)"),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: pickImage,
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: images
                  .map((e) => Image.file(e, width: 70, height: 70))
                  .toList(),
            ),
            const SizedBox(height: 25),
            _yellowButton("Enviar reclamo", () {
              Navigator.pushReplacementNamed(context, "/case-review");
            }),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            )
          ],
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Leonardo Giménez",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("Total del trabajo: \$12.000"),
          Text(
            "Saldo a pagar: \$10.200",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
          backgroundColor: const Color(0xffffcc00),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
