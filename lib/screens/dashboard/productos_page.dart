import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductosPage extends StatefulWidget {
  final bool esAdmin;

  const ProductosPage({super.key, required this.esAdmin});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  List productos = [];
  bool cargando = true;

  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController descripcionCtrl = TextEditingController();
  final TextEditingController precioCtrl = TextEditingController();
  final TextEditingController stockCtrl = TextEditingController();

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
    }
  }

  Future<void> crearProducto() async {
    // 🔐 DOBLE BLOQUEO (FRONTEND)
    if (!widget.esAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No tienes permisos para agregar productos'),
        ),
      );
      return;
    }

    if (nombreCtrl.text.isEmpty ||
        precioCtrl.text.isEmpty ||
        stockCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos')),
      );
      return;
    }

    final url = Uri.parse(
        'http://10.0.2.2/flashnet_api/crear_producto.php');

    final body = jsonEncode({
      "rol": "admin", // 🔐 SOLO ADMIN ENVÍA ESTO
      "nombre": nombreCtrl.text.trim(),
      "descripcion": descripcionCtrl.text.trim(),
      "precio": double.parse(precioCtrl.text),
      "stock": int.parse(stockCtrl.text)
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        Navigator.pop(context);
        cargarProductos();

        nombreCtrl.clear();
        descripcionCtrl.clear();
        precioCtrl.clear();
        stockCtrl.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Producto agregado correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text(data['message'] ?? 'Error al crear producto')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión')),
      );
    }
  }

  void mostrarFormulario() {
    // 🔐 BLOQUEO DEFINITIVO
    if (!widget.esAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acceso denegado: solo administrador'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nuevo Producto'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nombreCtrl,
                decoration:
                const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionCtrl,
                decoration:
                const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: precioCtrl,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: 'Precio'),
              ),
              TextField(
                controller: stockCtrl,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: 'Stock'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: crearProducto,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),

      // 🔐 SOLO ADMIN VE EL BOTÓN +
      floatingActionButton: widget.esAdmin
          ? FloatingActionButton(
        onPressed: mostrarFormulario,
        child: const Icon(Icons.add),
      )
          : null,

      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : productos.isEmpty
          ? const Center(child: Text('No hay productos'))
          : ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final p = productos[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6),
            child: ListTile(
              title: Text(p['nombre']),
              subtitle: Text(
                  'Precio: \$${p['precio']} | Stock: ${p['stock']}'),
            ),
          );
        },
      ),
    );
  }
}
