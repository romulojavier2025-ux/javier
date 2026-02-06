import 'package:flutter/material.dart';
import 'ventas_page.dart';
import 'productos_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel Usuario")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.person, size: 100),
            const SizedBox(height: 20),

            // ===== VENTAS =====
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VentasPage(),
                  ),
                );
              },
              child: const Text("VENTAS"),
            ),

            const SizedBox(height: 15),

            // ===== VER INVENTARIO =====
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductosPage(),   // ✅ CORREGIDO
                  ),
                );
              },
              child: const Text("VER INVENTARIO"),
            ),

          ],
        ),
      ),
    );
  }
}
