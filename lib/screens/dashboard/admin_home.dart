import 'package:flutter/material.dart';
import 'productos_page.dart';
import 'ventas_page.dart';
import 'factura_page.dart';
import 'registrar_usuario_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel Administrador")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.admin_panel_settings, size: 100),
            const SizedBox(height: 20),

            // ===== PRODUCTOS =====
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductosPage(),   // ✅ CORREGIDO
                  ),
                );
              },
              child: const Text("PRODUCTOS"),
            ),

            const SizedBox(height: 10),

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

            const SizedBox(height: 10),

            // ===== FACTURAS =====
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FacturasPage(),
                  ),
                );
              },
              child: const Text("FACTURAS"),
            ),

            const SizedBox(height: 10),

            // ===== REGISTRAR USUARIO =====
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrarUsuarioPage(),
                  ),
                );
              },
              child: const Text("REGISTRAR USUARIO"),
            ),

          ],
        ),
      ),
    );
  }
}
