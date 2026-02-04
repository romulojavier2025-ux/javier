import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String tipo;

  const HomePage({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlashNet")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Usuario tipo: $tipo",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            // ====== MENÚ ADMIN ======
            if (tipo == "admin") ...[

              ElevatedButton(
                onPressed: () {
                  // luego irá pantalla inventario
                },
                child: const Text("INVENTARIO"),
              ),

              ElevatedButton(
                onPressed: () {
                  // luego irá pantalla vender
                },
                child: const Text("VENDER"),
              ),

              ElevatedButton(
                onPressed: () {
                  // luego irá pantalla facturas
                },
                child: const Text("REVISAR FACTURAS"),
              ),

            ],

            // ====== MENÚ USUARIO ======
            if (tipo == "usuario") ...[

              ElevatedButton(
                onPressed: () {},
                child: const Text("VER MIS FACTURAS"),
              ),

            ]

          ],
        ),
      ),
    );
  }
}
