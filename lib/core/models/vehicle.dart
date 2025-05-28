class Vehicle {
  final String matricula;
  final String marca;
  final String modelo;
  final String estado;

  Vehicle({
    required this.matricula,
    required this.marca,
    required this.modelo,
    required this.estado,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      matricula: json['matricula'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      estado: json['estado'] ?? '',
    );
  }
}
