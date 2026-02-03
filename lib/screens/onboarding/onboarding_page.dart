import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          buildPage(
            icon: Icons.store,
            title: "Bienvenido a FlashNet",
            text: "Tu papelería y servicio técnico en un solo lugar",
          ),
          buildPage(
            icon: Icons.speed,
            title: "Rápido y Fácil",
            text: "Registra productos y ventas fácilmente",
          ),
          buildLastPage(context),
        ],
      ),
    );
  }

  Widget buildPage({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: Colors.blue),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildLastPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock, size: 120, color: Colors.blue),
          const SizedBox(height: 40),
          const Text(
            "Seguro",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "Tus datos siempre protegidos",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/benefits');
            },
            child: const Text("Comenzar"),
          ),
        ],
      ),
    );
  }
}

