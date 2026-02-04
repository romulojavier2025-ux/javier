import 'package:flutter/material.dart';

// ===== IMPORTS CORRECTOS SEGÚN TU CÓDIGO =====
import '../dashboard/admin_home.dart';
import '../dashboard/user_home.dart';

class LoginRealPage extends StatefulWidget {
  const LoginRealPage({super.key});

  @override
  State<LoginRealPage> createState() => _LoginRealPageState();
}

class _LoginRealPageState extends State<LoginRealPage> {

  final correoCtrl = TextEditingController();
  final claveCtrl = TextEditingController();

  void ingresar() {

    if (correoCtrl.text.isEmpty || claveCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingrese correo y contraseña"),
        ),
      );
      return;
    }

    bool esAdmin =
        correoCtrl.text == "admin@flash.com" ||
            correoCtrl.text == "romulo@test.com";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Bienvenido: ${correoCtrl.text}"),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {

      if (esAdmin) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomePage(),   // 👈 AQUÍ ESTÁ LA CORRECCIÓN
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserHomePage(),    // 👈 seguro así se llama
          ),
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: correoCtrl,
              decoration: const InputDecoration(labelText: "Correo"),
            ),

            TextField(
              controller: claveCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: ingresar,
              child: const Text("INGRESAR"),
            )

          ],
        ),
      ),
    );
  }
}
