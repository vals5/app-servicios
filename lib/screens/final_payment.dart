import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FinalPaymentScreen extends StatefulWidget {
  const FinalPaymentScreen({super.key});

  @override
  State<FinalPaymentScreen> createState() => _FinalPaymentScreenState();
}

class _FinalPaymentScreenState extends State<FinalPaymentScreen> {
  File? comprobante;
  final picker = ImagePicker();

  Future<void> pickComprobante() async {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        comprobante = File(img.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Pagar saldo'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// RESUMEN
            _card(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Leonardo Giménez',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Electricista'),
                  SizedBox(height: 8),
                  Text('Jue 15:30 – 16:30'),
                  Divider(),
                  Text(
                    'Saldo a pagar: \$10.200',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 159, 226),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/fp-confirmed');
              },
              child: const Text('Pagar con MercadoPago'),
            ),

            const SizedBox(height: 18),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Transferencia bancaria',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('CBU: 0000003100000001234567'),
                  Text('Alias: SERVICIOS.APP'),
                  Text('Banco Nación'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: pickComprobante,
              child: const Text('Subir comprobante'),
            ),

            if (comprobante != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.file(comprobante!, height: 120),
              ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7D400),
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/fp-confirmed');
                    },
                    child: const Text('Confirmar pago'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7D400),
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black12),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/disagree');
                    },
                    child: const Text('No estoy de acuerdo'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}
