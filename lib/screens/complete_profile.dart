import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/profile_provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  final Map<String, TextEditingController> _controllers = {
    'nombre': TextEditingController(),
    'telefono': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'domicilio': TextEditingController(),
    'rubro': TextEditingController(),
    'zona': TextEditingController(),
    'descripcion': TextEditingController(),
  };

  bool aceptaTerminos = false;

  Future<void> _pickImage(ProfileProvider provider) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setProfileImage(File(pickedFile.path));
    }
  }

  int _calculateProgress(String userType) {
    int completed = 0;

    if (_controllers['nombre']!.text.isNotEmpty) completed++;
    if (_controllers['telefono']!.text.isNotEmpty) completed++;
    if (_controllers['email']!.text.isNotEmpty) completed++;

    if (userType == 'cliente') {
      if (_controllers['domicilio']!.text.isNotEmpty) completed++;
      return ((completed / 4) * 100).round();
    } else {
      if (_controllers['password']!.text.isNotEmpty) completed++;
      if (_controllers['rubro']!.text.isNotEmpty) completed++;
      if (_controllers['zona']!.text.isNotEmpty) completed++;
      if (_controllers['descripcion']!.text.isNotEmpty) completed++;
      if (aceptaTerminos) completed++;
      return ((completed / 8) * 100).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final userType = provider.userType ?? 'cliente';
    final progress = _calculateProgress(userType);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7D400),
        title: const Text(
          'Completá tu perfil',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.resetProfile();
              Navigator.pop(context);
            },
            child: const Text(
              'Cambiar tipo',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // FOTO PERFIL
            GestureDetector(
              onTap: () => _pickImage(provider),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                backgroundImage: provider.profileImage != null
                    ? FileImage(provider.profileImage!)
                    : null,
                child: provider.profileImage == null
                    ? const Icon(
                        Icons.camera_alt,
                        color: Color(0xFFF7D400),
                        size: 30,
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Perfil completado: $progress%',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: progress / 100,
              minHeight: 8,
              backgroundColor: Colors.black12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),

            const SizedBox(height: 30),

            _input('Nombre y apellido', _controllers['nombre']!),
            _input('Teléfono', _controllers['telefono']!),
            _input('Email', _controllers['email']!),

            if (userType == 'cliente')
              _input('Domicilio', _controllers['domicilio']!),

            if (userType == 'profesional') ...[
              _input(
                'Contraseña',
                _controllers['password']!,
                obscure: true,
              ),
              _input('Rubro principal', _controllers['rubro']!),
              _input('Zona principal', _controllers['zona']!),
              _input(
                'Descripción breve',
                _controllers['descripcion']!,
                maxLines: 3,
              ),
              CheckboxListTile(
                value: aceptaTerminos,
                onChanged: (v) => setState(() => aceptaTerminos = v ?? false),
                title: const Text('Acepto términos y condiciones'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: progress >= 60
                    ? () {
                        if (userType == 'cliente') {
                          Navigator.pushReplacementNamed(
                              context, '/home-cliente');
                        } else {
                          Navigator.pushReplacementNamed(
                              context, '/home-profesional');
                        }
                      }
                    : null,
                child: Text(
                  userType == 'profesional'
                      ? 'CREAR CUENTA PROFESIONAL'
                      : 'GUARDAR PERFIL',
                  style: const TextStyle(
                    color: Color(0xFFF7D400),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
