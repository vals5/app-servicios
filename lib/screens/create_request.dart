import 'dart:io';
import 'package:app_servicios/screens/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final ImagePicker _picker = ImagePicker();

  final List<File> _images = [];
  File? _video;

  /* ---------- IMÁGENES ---------- */

  Future<void> _pickImage(ImageSource source) async {
    final XFile? img = await _picker.pickImage(source: source);
    if (img != null && _images.length < 3) {
      setState(() => _images.add(File(img.path)));
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _bottomPicker(
        onGallery: () => _pickImage(ImageSource.gallery),
        onCamera: () => _pickImage(ImageSource.camera),
      ),
    );
  }

  /* ---------- VIDEO ---------- */

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? vid = await _picker.pickVideo(source: source);
    if (vid != null) {
      setState(() => _video = File(vid.path));
    }
  }

  void _showVideoPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _bottomPicker(
        onGallery: () => _pickVideo(ImageSource.gallery),
        onCamera: () => _pickVideo(ImageSource.camera),
      ),
    );
  }

  /* ---------- UI ---------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Electricista',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitle(
                            icon: Icons.location_on,
                            title: '¿Dónde es el servicio?',
                          ),
                          SizedBox(height: 10),
                          _LocationBox(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitle(
                            icon: Icons.edit,
                            title: '¿Qué está pasando?',
                          ),
                          SizedBox(height: 10),
                          _DescriptionInput(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 📸 FOTOS
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionTitle(
                            icon: Icons.camera_alt,
                            title: 'Fotos del problema (mín. 3)',
                          ),
                          const SizedBox(height: 10),
                          _actionCard(
                            icon: Icons.camera_alt,
                            text: 'Agregar foto',
                            counter: '${_images.length} / 3',
                            onTap:
                                _images.length >= 3 ? null : _showImagePicker,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Opcional – ayuda a que te presupuesten mejor',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          if (_images.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _images.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (_, i) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _images[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🎥 VIDEO
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionTitle(
                            icon: Icons.videocam,
                            title: 'Video del problema (opcional, máx. 10s)',
                          ),
                          const SizedBox(height: 10),
                          _actionCard(
                            icon: Icons.videocam,
                            text: _video == null
                                ? 'Agregar video'
                                : 'Video agregado',
                            counter: _video == null ? '' : '1',
                            onTap: _showVideoPicker,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Opcional – ayuda a que te presupuesten mejor',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitle(
                            icon: Icons.list_alt,
                            title: 'Resumen',
                          ),
                          SizedBox(height: 8),
                          Text('• Electricista'),
                          SizedBox(height: 4),
                          Text('📍 Valen - Guaymallén'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),

            /// 🔘 BOTÓN
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF7D400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcceptBudgetScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Publicar solicitud',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ---------- HELPERS ---------- */

  Widget _actionCard({
    required IconData icon,
    required String text,
    String counter = '',
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7D400).withOpacity(0.25),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            if (counter.isNotEmpty) Text(counter),
          ],
        ),
      ),
    );
  }

  Widget _bottomPicker({
    required VoidCallback onGallery,
    required VoidCallback onCamera,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Elegir de la galería'),
          onTap: () {
            Navigator.pop(context);
            onGallery();
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Sacar ahora'),
          onTap: () {
            Navigator.pop(context);
            onCamera();
          },
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: child,
    );
  }
}

/* ---------- COMPONENTES ---------- */

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}

class _LocationBox extends StatelessWidget {
  const _LocationBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.place),
          SizedBox(width: 10),
          Expanded(
            child: Text('Valen - Guaymallén\nCambiar | Agregar otro'),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Ej: Se cortó la luz en la cocina y salta la térmica',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
