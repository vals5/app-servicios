import 'package:flutter/material.dart';

class CrearCuentaScreen extends StatefulWidget {
  const CrearCuentaScreen({super.key});

  @override
  State<CrearCuentaScreen> createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
  bool soyProfesional = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          color: const Color(0xFFF5A623),
          child: const Center(
            child: Text(
              "Rapi Arreglo",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Crear cuenta",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Selector usuario / profesional
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectorTipo("Soy Usuario", false),
                const SizedBox(width: 10),
                _selectorTipo("Soy Profesional", true),
              ],
            ),

            const SizedBox(height: 25),

            _input("Nombre completo"),
            _input("Correo electrónico"),
            _input("Número de teléfono"),

            const SizedBox(height: 20),

            // Botón registrarse
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Registrarse",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 25),

            if (soyProfesional) ...[
              const Text(
                "Registro Profesional",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() => soyProfesional = false);
                },
                child: const Text("Cambiar a usuario"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _selectorTipo(String text, bool profesional) {
    final bool activo = profesional == soyProfesional;

    return GestureDetector(
      onTap: () {
        setState(() => soyProfesional = profesional);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: activo ? const Color(0xFFF5A623) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: activo ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _input(String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
      ),
    );
  }
}
