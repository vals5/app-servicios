import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7D400),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 80),

            /// LOGO R
            Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "R",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF7D400),
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 15),

                const Text(
                  "RAPI",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
                const Text(
                  "ARREGLO",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// INPUTS
            const _CustomInput(label: "Nombre completo", obscure: false),
            const SizedBox(height: 20),

            const _CustomInput(label: "Correo electrónico", obscure: false),
            const SizedBox(height: 20),

            const _CustomInput(label: "Contraseña", obscure: true),
            const SizedBox(height: 20),

            const _CustomInput(label: "Confirmar contraseña", obscure: true),

            const SizedBox(height: 40),

            /// BOTON REGISTER
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "REGISTRAR",
                  style: TextStyle(
                    color: Color(0xFFF7D400),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "¿Ya tenes cuenta?",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, "/login"),
              child: const Text(
                "Ingresar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// MISMO INPUT QUE EN LOGIN
class _CustomInput extends StatelessWidget {
  final String label;
  final bool obscure;

  const _CustomInput({
    required this.label,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.black, width: 2.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    );
  }
}