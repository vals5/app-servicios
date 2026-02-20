import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FinalPaymentScreen extends StatefulWidget {
  const FinalPaymentScreen({super.key});

  @override
  State<FinalPaymentScreen> createState() => _FinalPaymentScreenState();
}

class _FinalPaymentScreenState extends State<FinalPaymentScreen> {
  File? comprobante;
  final picker = ImagePicker();

  Future<void> pickComprobante() async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => comprobante = File(img.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Trabajo finalizado',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.circle, size: 10, color: Colors.orange),
                SizedBox(width: 6),
                Text('Pendiente de pago',
                    style: TextStyle(color: Colors.orange)),
              ],
            ),
            const SizedBox(height: 14),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            AssetImage('assets/images/professional.png'),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Leonardo Giménez',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Electricista'),
                          Text('Jue 15:30 – 16:30'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Comentario:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Cambio de térmica y revisión de tablero eléctrico.',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/job-finished.png',
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemCount: 3,
                    ),
                  ),
                  const Divider(height: 24),
                  _row('Total del trabajo', '\$12.000'),
                  _row('Seña pagada', '\$1.800'),
                  const SizedBox(height: 6),
                  _rowBold('Saldo a pagar', '\$10.200'),
                  const SizedBox(height: 6),
                  const Text(
                    'Este es el importe final del trabajo realizado.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7D400),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fp-confirmed');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/MP.png', height: 26),
                    const SizedBox(width: 10),
                    const Text(
                      'Pagar con Mercado Pago',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CBU: 0000003100000001234567'),
                  const Text('Alias: RAPI.ARREGLO'),
                  const Text('Banco Nación'),
                  const Divider(),
                  TextButton(
                    onPressed: pickComprobante,
                    child: const Text('Subir comprobante'),
                  ),
                  if (comprobante != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Image.file(comprobante!, height: 90),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _card(
              child: Row(
                children: const [
                  Icon(Icons.payments, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pagar en efectivo al profesional\n'
                      'El profesional registrará el pago una vez recibido.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/disagree');
              },
              child: const Text('No estoy de acuerdo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String l, String r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(l), Text(r)],
    );
  }

  Widget _rowBold(String l, String r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(r, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
