import 'package:flutter/material.dart';
import 'screens/auth/login_real.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlashNet',

      // ===== AQUI ESTÁ EL CAMBIO =====
      theme: ThemeData(

        primaryColor: const Color(0xFF1565C0),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
          ),
        ),

        inputDecorationTheme: const InputDecorationTheme(

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF1565C0),
              width: 2,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
      // ===== FIN DEL CAMBIO =====

      home: const LoginRealPage(),
    );
  }
}
