import 'package:flutter/material.dart';

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

    // 👇 Aquí luego conectamos con tu API PHP

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Bienvenido: ${correoCtrl.text}"),
      ),
    );
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
              keyboardType: TextInputType.emailAddress,
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
