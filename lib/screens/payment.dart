import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File? receiptImage;

  /* ======================================================
                        PICK IMAGE
  ====================================================== */

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (file != null) {
      setState(() {
        receiptImage = File(file.path);
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Tomar foto"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Elegir de galería"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /* ======================================================
                        UI
  ====================================================== */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      /* ---------------- APPBAR ---------------- */
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Pago del servicio",
          style: TextStyle(color: Colors.black),
        ),
      ),

      /* ---------------- BOTÓN FIJO ---------------- */
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF7D400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/payment-confirmed');
            },
            child: const Text(
              "Confirmar pago",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      /* ---------------- BODY ---------------- */
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _serviceInfoCard(),
            const SizedBox(height: 14),
            _totalCard(),
            const SizedBox(height: 14),
            _mercadoPagoButton(context),
            const SizedBox(height: 14),
            _transferCard(),
            const SizedBox(height: 14),
            _uploadReceipt(),
          ],
        ),
      ),
    );
  }

  /* ======================================================
                      COMPONENTES
  ====================================================== */

  /* ---------- INFO SERVICIO ---------- */
  Widget _serviceInfoCard() {
    return _card(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Detalle del turno",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _Row("Profesional", "Leonardo Giménez"),
          _Row("Servicio", "Electricista"),
          _Row("Día", "Martes 12 de marzo"),
          _Row("Hora", "15:30 hs"),
        ],
      ),
    );
  }

  /* ---------- TOTAL ---------- */
  Widget _totalCard() {
    return _card(
      child: const Column(
        children: [
          Text("Total a pagar", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 6),
          Text(
            "\$1.800",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /* ---------- MERCADO PAGO ---------- */
  Widget _mercadoPagoButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.account_balance_wallet),
        label: const Text("Pagar con Mercado Pago"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/confirmation');
        },
      ),
    );
  }

  /* ---------- TRANSFERENCIA ---------- */
  Widget _transferCard() {
    return _card(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transferencia bancaria",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _Row("Banco", "Banco Nación"),
          _Row("CBU", "0001234560000000001234"),
          _Row("Alias", "rappi.servicios"),
          _Row("Titular", "Rappi Servicios SAS"),
        ],
      ),
    );
  }

  /* ---------- SUBIR COMPROBANTE ---------- */
  Widget _uploadReceipt() {
    return _card(
      child: Column(
        children: [
          const Text(
            "Comprobante de pago",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showPicker,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: receiptImage == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload, size: 32),
                        SizedBox(height: 6),
                        Text("Subir comprobante"),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(receiptImage!, fit: BoxFit.cover),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /* ---------- CARD BASE ---------- */
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

/* ======================================================
                      ROW INFO
====================================================== */

class _Row extends StatelessWidget {
  final String left;
  final String right;

  const _Row(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(right, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
