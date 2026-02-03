import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../dashboard/admin_home.dart';
import '../dashboard/user_home.dart';
import 'register_page.dart';   // ← TU ARCHIVO REAL

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool loading = false;

  // ============================
  // VALIDAR FORMATO CORREO
  // ============================
  bool validarCorreo(String correo) {
    return RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(correo);
  }

  // ============================
  // FUNCIÓN LOGIN
  // ============================
  Future<void> login() async {

    FocusScope.of(context).unfocus();

    final correo = emailCtrl.text.trim();
    final password = passCtrl.text.trim();

    // 🔐 Validaciones
    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese correo y contraseña')),
      );
      return;
    }

    if (!validarCorreo(correo)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo no válido')),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final res = await http.post(
        Uri.parse('http://10.0.2.2/flashnet_api/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "correo": correo,
          "password": password
        }),
      );

      final data = jsonDecode(res.body);

      setState(() => loading = false);

      if (data['status'] == 'ok') {

        final rol = data['user']['rol'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => rol == 'admin'
                ? const AdminHomePage()
                : const UserHomePage(),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error de login')),
        );
      }

    } catch (e) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión con el servidor')),
      );
    }
  }

  // ============================
  // DISEÑO INTERFAZ
  // ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login FlashNet')),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(Icons.store, size: 80),
            const SizedBox(height: 20),

            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo',
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              onSubmitted: (_) => login(),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: loading ? null : login,

                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('INGRESAR'),
              ),
            ),

            const SizedBox(height: 10),

            // 🔁 IR A REGISTRO
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterPage(),
                  ),
                );
              },
              child: const Text("Crear cuenta"),
            )

          ],
        ),
      ),
    );
  }
}
