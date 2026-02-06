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

  final cedulaCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final claveCtrl = TextEditingController();
  final confirmarCtrl = TextEditingController();
  final ciudadCtrl = TextEditingController();
  final cargoCtrl = TextEditingController();

  String rol = 'user';
  bool cargando = false;

  // 👇 PARA EL OJITO
  bool verClave = false;
  bool verConfirmar = false;

  // ===== ESTILO DE BORDES =====
  InputDecoration estilo(String label) {
    return InputDecoration(
      labelText: label,

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),

      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),

      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),

      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  // ===== VALIDACIÓN CÉDULA ECUATORIANA =====
  bool esCedulaEcuatoriana(String cedula) {
    if (cedula.length != 10) return false;

    if (!RegExp(r'^[0-9]+$').hasMatch(cedula)) return false;

    int provincia = int.parse(cedula.substring(0, 2));
    if (provincia < 1 || provincia > 24) return false;

    int tercer = int.parse(cedula[2]);
    if (tercer >= 6) return false;

    List<int> coeficientes = [2,1,2,1,2,1,2,1,2];
    int suma = 0;

    for (int i = 0; i < 9; i++) {
      int digito = int.parse(cedula[i]);
      int valor = digito * coeficientes[i];
      if (valor >= 10) valor -= 9;
      suma += valor;
    }

    int digitoVerificador = int.parse(cedula[9]);
    int decena = ((suma / 10).ceil()) * 10;
    int resultado = decena - suma;

    if (resultado == 10) resultado = 0;

    return resultado == digitoVerificador;
  }

  String? validarCedula(String? v) {
    if (v == null || v.isEmpty) return "Ingrese la cédula";
    if (!esCedulaEcuatoriana(v)) return "Cédula ecuatoriana no válida";
    return null;
  }

  String? validarVacio(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  String? validarCorreo(String? v) {
    if (v == null || v.isEmpty) return "Ingrese correo";

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(v)) return "Correo inválido";

    return null;
  }

  String? validarClave(String? v) {
    if (v == null || v.isEmpty) return "Ingrese contraseña";
    if (v.length < 2) return "Mínimo 2 caracteres";
    return null;
  }

  String? validarConfirmar(String? v) {
    if (v == null || v.isEmpty) return "Confirme la contraseña";
    if (v != claveCtrl.text) return "Las contraseñas no coinciden";
    return null;
  }

  // ===== REGISTRO =====
  Future<void> registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => cargando = true);

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/flashnet_api/registrar_usuario.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "admin_rol": "admin",
          "cedula": cedulaCtrl.text.trim(),
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

  Widget campo({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    bool oculto = false,
    bool esConfirmar = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: TextFormField(
        controller: controller,

        decoration: estilo(label).copyWith(

          // 👁 OJITO
          suffixIcon: oculto
              ? IconButton(
            icon: Icon(
              esConfirmar
                  ? (verConfirmar
                  ? Icons.visibility
                  : Icons.visibility_off)
                  : (verClave
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),

            onPressed: () {
              setState(() {
                if (esConfirmar) {
                  verConfirmar = !verConfirmar;
                } else {
                  verClave = !verClave;
                }
              });
            },
          )
              : null,
        ),

        obscureText: oculto
            ? (esConfirmar ? !verConfirmar : !verClave)
            : false,

        keyboardType: tipo,

        onFieldSubmitted: (_) {
          if (validator(controller.text) != null) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },

        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
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

              campo(
                controller: cedulaCtrl,
                label: "Cédula",
                validator: validarCedula,
                tipo: TextInputType.number,
              ),

              campo(
                controller: nombreCtrl,
                label: "Nombre",
                validator: validarVacio,
              ),

              campo(
                controller: correoCtrl,
                label: "Correo",
                validator: validarCorreo,
                tipo: TextInputType.emailAddress,
              ),

              campo(
                controller: claveCtrl,
                label: "Contraseña",
                validator: validarClave,
                oculto: true,
              ),

              campo(
                controller: confirmarCtrl,
                label: "Confirmar contraseña",
                validator: validarConfirmar,
                oculto: true,
                esConfirmar: true,
              ),

              campo(
                controller: ciudadCtrl,
                label: "Ciudad",
                validator: validarVacio,
              ),

              campo(
                controller: cargoCtrl,
                label: "Cargo",
                validator: validarVacio,
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: cargando ? null : registrarUsuario,
                  child: Text(
                    cargando ? 'Registrando...' : 'Registrar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
