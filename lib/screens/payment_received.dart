import 'package:flutter/material.dart';

class PaymentReceivedScreen extends StatefulWidget {
  const PaymentReceivedScreen({super.key});

  @override
  State<PaymentReceivedScreen> createState() => _PaymentReceivedScreenState();
}

class _PaymentReceivedScreenState extends State<PaymentReceivedScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  String? _metodoPago; // 'efectivo' | 'transferencia'
  bool _pagoParcial = false;
  bool _reciboAdjunto = false;
  bool _clienteAcuerdo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(context),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Ilustración billetera
                  _buildWalletIllustration(),
                  const SizedBox(height: 20),

                  // Título
                  const Center(
                    child: Text(
                      'Pago recibido',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(
                              text: 'Confirmaste que recibiste el pago\nde '),
                          TextSpan(
                            text: '\$25.000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Método de pago
                  const Text(
                    'Método de pago',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildOpcionMetodo(
                    valor: 'efectivo',
                    icon: Icons.money,
                    texto: 'Recibí efectivo',
                  ),
                  const SizedBox(height: 8),
                  _buildOpcionMetodo(
                    valor: 'transferencia',
                    icon: Icons.swap_horiz,
                    texto: 'Recibí transferencia',
                  ),
                  const SizedBox(height: 8),
                  _buildOpcionPagoParcial(),
                  const SizedBox(height: 20),

                  // Opciones extra
                  _buildOpcionRecibo(),
                  const SizedBox(height: 10),
                  _buildOpcionAcuerdo(),
                  const SizedBox(height: 6),
                  Text(
                    'La comición se calcuai cobre el monto registrado.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón confirmar
                  _buildBotonConfirmar(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _darkBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildWalletIllustration() {
    return Center(
      child: SizedBox(
        height: 120,
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Estrellas/confetti
            ...List.generate(8, (i) {
              final offsets = [
                const Offset(-75, -30),
                const Offset(75, -30),
                const Offset(-80, 10),
                const Offset(80, 10),
                const Offset(-55, 40),
                const Offset(55, 40),
                const Offset(-30, -45),
                const Offset(30, -45),
              ];
              final colors = [
                _amarillo,
                Colors.green,
                _amarillo,
                Colors.green,
                _amarillo,
                Colors.green,
                _amarillo,
                Colors.green
              ];
              return Transform.translate(
                offset: offsets[i],
                child: Icon(Icons.star, color: colors[i], size: 14),
              );
            }),
            const Text('💰', style: TextStyle(fontSize: 72)),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionMetodo({
    required String valor,
    required IconData icon,
    required String texto,
  }) {
    final seleccionado = _metodoPago == valor;
    return GestureDetector(
      onTap: () => setState(() => _metodoPago = valor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: seleccionado ? Colors.green : Colors.black12,
            width: seleccionado ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20, color: seleccionado ? Colors.green : Colors.black54),
            const SizedBox(width: 12),
            Text(
              texto,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: seleccionado ? Colors.green : Colors.black87,
                fontWeight: seleccionado ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionPagoParcial() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_outlined,
              size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Pago parcial',
              style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            ),
          ),
          Switch(
            value: _pagoParcial,
            onChanged: (val) => setState(() => _pagoParcial = val),
            activeThumbColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildOpcionRecibo() {
    return GestureDetector(
      onTap: () => setState(() => _reciboAdjunto = !_reciboAdjunto),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Icon(Icons.receipt_outlined, size: 16, color: Colors.pink[300]),
          ),
          const SizedBox(width: 10),
          const Text(
            'Recibo como respaldo (opcional)',
            style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  Widget _buildOpcionAcuerdo() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _clienteAcuerdo = !_clienteAcuerdo),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _clienteAcuerdo ? Colors.green[50] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.check,
              size: 18,
              color: _clienteAcuerdo ? Colors.green : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'El cliente está de acuerdo con este monto',
            style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }

  Widget _buildBotonConfirmar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_metodoPago == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Seleccioná un método de pago.',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          Navigator.pushNamed(context, '/rate-client');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Confirmar y continuar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home-profesional');
          }
        },
        selectedItemColor: _amarillo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontSize: 11),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: 'Solicitudes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded), label: 'Agenda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Ganancias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
