import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrarUsuarioPage extends StatefulWidget {
  const RegistrarUsuarioPage({super.key});

  @override
  State<RegistrarUsuarioPage> createState() => _RegistrarUsuarioPageState();
}

class _RegistrarUsuarioPageState extends State<RegistrarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();

  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final claveCtrl = TextEditingController();
  final ciudadCtrl = TextEditingController();
  final cargoCtrl = TextEditingController();

  String rol = 'user';
  bool cargando = false;

  Future<void> registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => cargando = true);

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/flashnet_api/registrar_usuario.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "admin_rol": "admin", // SOLO ADMIN
          "nombre": nombreCtrl.text.trim(),
          "correo": correoCtrl.text.trim(),
          "clave": claveCtrl.text.trim(),
          "rol": rol,
          "ciudad": ciudadCtrl.text.trim(),
          "cargo": cargoCtrl.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      setState(() => cargando = false);

      if (data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado correctamente')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error')),
        );
      }
    } catch (e) {
      setState(() => cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    correoCtrl.dispose();
    claveCtrl.dispose();
    ciudadCtrl.dispose();
    cargoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: correoCtrl,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: claveCtrl,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
              ),
              DropdownButtonFormField(
                value: rol,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('Usuario')),
                  DropdownMenuItem(value: 'admin', child: Text('Administrador')),
                ],
                onChanged: (v) => setState(() => rol = v.toString()),
              ),
              TextFormField(
                controller: ciudadCtrl,
                decoration: const InputDecoration(labelText: 'Ciudad'),
              ),
              TextFormField(
                controller: cargoCtrl,
                decoration: const InputDecoration(labelText: 'Cargo'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: cargando ? null : registrarUsuario,
                  child: Text(cargando ? 'Registrando...' : 'Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
