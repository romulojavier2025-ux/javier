import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VentasPage extends StatefulWidget {
  const VentasPage({super.key});

  @override
  State<VentasPage> createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  List productos = [];
  List carrito = [];
  double total = 0;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    try {
      final url = Uri.parse(
          'http://10.0.2.2/flashnet_api/listar_productos.php');

      final response = await http.get(url);
      final json = jsonDecode(response.body);

      setState(() {
        productos = json['data'];
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar productos')),
      );
    }
  }

  void agregarProducto(Map p) {
    setState(() {
      carrito.add({
        "producto_id": int.parse(p['id'].toString()),
        "cantidad": 1,
        "precio": double.parse(p['precio'].toString())
      });
      total += double.parse(p['precio'].toString());
    });
  }

  Future<void> generarFactura() async {
    final url = Uri.parse(
        'http://10.0.2.2/flashnet_api/registrar_venta.php');

    final body = jsonEncode({
      "cliente_id": 1,
      "usuario_id": 1,
      "items": carrito
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text('Factura #${data['factura_id']} creada')),
        );

        setState(() {
          carrito.clear();
          total = 0;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  data['message'] ?? 'Error al generar factura')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error de conexión con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final p = productos[index];
                return ListTile(
                  title: Text(p['nombre']),
                  subtitle: Text('\$${p['precio']}'),
                  trailing: const Icon(Icons.add_circle),
                  onTap: () => agregarProducto(p),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.receipt_long),
                    label: const Text('FACTURAR'),
                    onPressed:
                    carrito.isEmpty ? null : generarFactura,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
