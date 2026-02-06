import 'package:flutter/material.dart';

// IMPORTS DE TUS PANTALLAS
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

  // 👇 NUEVO
  String tipoUsuario = "usuario";

  void ingresar() {

    if (correoCtrl.text.isEmpty || claveCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingrese correo y contraseña"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Bienvenido: ${correoCtrl.text}"),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {

      if (tipoUsuario == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomePage(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserHomePage(),
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

            const SizedBox(height: 10),

            // 👇 SELECTOR NUEVO
            DropdownButtonFormField(
              value: tipoUsuario,
              decoration: const InputDecoration(
                labelText: "Tipo de usuario",
              ),
              items: const [
                DropdownMenuItem(
                  value: "usuario",
                  child: Text("Usuario"),
                ),
                DropdownMenuItem(
                  value: "admin",
                  child: Text("Administrador"),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  tipoUsuario = v.toString();
                });
              },
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
