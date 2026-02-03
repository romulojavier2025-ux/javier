import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto.dart';

class ProductoService {
  static const String baseUrl =
      "http://10.0.2.2/flashnet_api";

  // 🔹 LISTAR PRODUCTOS
  static Future<List<Producto>> obtenerProductos() async {
    final response =
    await http.get(Uri.parse("$baseUrl/listar_productos.php"));

    final data = jsonDecode(response.body);

    if (data["status"] == "ok") {
      return (data["data"] as List)
          .map((e) => Producto.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  // 🔹 INSERTAR PRODUCTO
  static Future<bool> insertarProducto({
    required String nombre,
    required String descripcion,
    required double precio,
    required int stock,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/insertar_producto.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "stock": stock,
      }),
    );

    final data = jsonDecode(response.body);
    return data["status"] == "ok";
  }
}
