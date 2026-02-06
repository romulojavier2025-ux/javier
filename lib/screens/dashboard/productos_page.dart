// 👇 DESDE AQUÍ PEGAS

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  List productos = [];

  final nombreCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  final stockCtrl  = TextEditingController();

  final String url =
      "http://192.168.1.101/flashnet_api/productos.php";

  Future<void> cargar() async {
    final r = await http.get(Uri.parse(url));
    productos = jsonDecode(r.body);
    setState(() {});
  }

  Future<void> guardar() async {

    await http.post(
        Uri.parse(url),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({
          "nombre": nombreCtrl.text,
          "precio": precioCtrl.text,
          "stock":  stockCtrl.text
        })
    );

    await cargar();
  }

  Future<void> eliminar(id) async {

    final uri = Uri.parse(
        "http://192.168.1.101/flashnet_api/productos.php?id=$id"
    );

    await http.delete(uri);

    await cargar();
  }

  @override
  void initState(){
    super.initState();
    cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Productos"),

        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: cargar,
          )
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [

                TextField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(
                      labelText: "Nombre"
                  ),
                ),

                TextField(
                  controller: precioCtrl,
                  decoration: const InputDecoration(
                      labelText: "Precio"
                  ),
                ),

                TextField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(
                      labelText: "Stock"
                  ),
                ),

                ElevatedButton(
                  onPressed: guardar,
                  child: const Text("AGREGAR"),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (c,i){

                final p = productos[i];

                return Card(
                  child: ListTile(
                    title: Text(p['nombre']),
                    subtitle: Text(
                        "Precio: ${p['precio']}  Stock: ${p['stock']}"
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red),
                      onPressed: ()=> eliminar(p['id']),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
