class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio']),
      stock: int.parse(json['stock']),
    );
  }
}
