import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String tipo;

  const HomePage({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlashNet")),

      body: Column(
        children: [

          Text("Tipo de usuario: $tipo"),

          if (tipo == "admin")
            ElevatedButton(
              onPressed: () {},
              child: const Text("Ver TODAS las facturas"),
            ),

          if (tipo == "usuario")
            ElevatedButton(
              onPressed: () {},
              child: const Text("Ver MIS facturas"),
            ),

        ],
      ),
    );
  }
}
