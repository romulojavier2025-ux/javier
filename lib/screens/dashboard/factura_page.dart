import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FacturasPage extends StatefulWidget {
  @override
  State<FacturasPage> createState() => _FacturasPageState();
}

class _FacturasPageState extends State<FacturasPage> {
  List facturas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarFacturas();
  }

  Future<void> cargarFacturas() async {
    try {
      final url = Uri.parse(
          'http://10.0.2.2/flashnet_api/listar_facturas.php');

      final response = await http.get(url);
      final json = jsonDecode(response.body);

      setState(() {
        facturas = json['data'];
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar facturas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Facturas')),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : facturas.isEmpty
          ? const Center(child: Text('No hay facturas'))
          : ListView.builder(
        itemCount: facturas.length,
        itemBuilder: (context, index) {
          final f = facturas[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(f['id'].toString()),
              ),
              title: Text(
                  'Cliente: ${f['cliente'] ?? 'Consumidor final'}'),
              subtitle: Text('Fecha: ${f['fecha']}'),
              trailing: Text(
                '\$${f['total']}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
