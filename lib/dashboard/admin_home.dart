import 'package:flutter/material.dart';

// IMPORTS CON RUTAS CORRECTAS SEGÚN TU PROYECTO
import '../screens/productos_page.dart';
import '../screens/ventas_page.dart';
import '../screens/factura_page.dart';
import '../screens/registrar_usuario_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  Widget tarjeta({
    required BuildContext context,
    required String titulo,
    required IconData icono,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icono, size: 36, color: color),
            ),

            const SizedBox(height: 12),

            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 👇👇 AQUÍ ESTÁ EL CAMBIO QUE QUIERES 👇👇
      appBar: AppBar(
        title: const Text("CAMBIO REAL 123"),
        backgroundColor: Colors.orange,
      ),
      // 👆👆👆

      body: Center(
        child: Text(
          "SI VEO ESTO\nESTE ES EL ARCHIVO CORRECTO",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
