import 'package:flutter/material.dart';
import 'login_real.dart';   // pantalla a donde irá después

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final claveCtrl = TextEditingController();

  void registrar() {

    if (nombreCtrl.text.isEmpty ||
        correoCtrl.text.isEmpty ||
        claveCtrl.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Todos los campos son obligatorios"),
        ),
      );
      return;
    }

    // Aquí luego conectaremos con tu API

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Usuario registrado con éxito"),
      ),
    );

    // Ir a login
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginRealPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),

            TextField(
              controller: correoCtrl,
              decoration: const InputDecoration(labelText: "Correo"),
              keyboardType: TextInputType.emailAddress,
            ),

            TextField(
              controller: claveCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: registrar,
              child: const Text("REGISTRAR"),
            )

          ],
        ),
      ),
    );
  }
}
