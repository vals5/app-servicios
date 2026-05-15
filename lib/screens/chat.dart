import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const Color _amarillo = Color(0xFFF7D400);
  static const Color _darkBg = Color(0xFF1C1F2A);

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _mensajes = [
    {'texto': 'Hola! Ya confirmé la visita para el martes.', 'mio': false},
    {'texto': 'Perfecto, ahí estaré a las 15:30.', 'mio': true},
    {'texto': 'Genial, te espero. El portón es el azul.', 'mio': false},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _enviarMensaje() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _mensajes.add({'texto': _controller.text.trim(), 'mio': true});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mensajes.length,
              itemBuilder: (_, i) => _buildBurbuja(_mensajes[i]),
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _darkBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16, bottom: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[700],
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leonardo Giménez',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 15)),
                Text('Electricista',
                    style: TextStyle(color: Colors.white54, fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildBurbuja(Map<String, dynamic> msg) {
    final bool mio = msg['mio'];
    return Align(
      alignment: mio ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: mio ? _amarillo : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(mio ? 16 : 4),
            bottomRight: Radius.circular(mio ? 4 : 16),
          ),
        ),
        child: Text(
          msg['texto'],
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: mio ? Colors.black : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.mic_none, color: Colors.black45, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Escribir mensaje...',
                hintStyle: const TextStyle(color: Colors.black38, fontFamily: 'Poppins'),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              onSubmitted: (_) => _enviarMensaje(),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.camera_alt_outlined, color: Colors.black45, size: 22),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _enviarMensaje,
            child: const Icon(Icons.send_rounded, color: _amarillo, size: 24),
          ),
        ],
      ),
    );
  }
}