class Conductor {
  final String nombreCompleto;
  final String apellido1;
  final String nombreInversor;

  Conductor({
    required this.nombreCompleto,
    required this.apellido1,
    required this.nombreInversor,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      nombreCompleto: json['nombreCompleto'] ?? '',
      apellido1: json['apellido1'] ?? '',
      nombreInversor: json['nombreInversor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'apellido1': apellido1,
      'nombreInversor': nombreInversor,
    };
  }
}
