class Inversor {
  final String id;
  final String nombreInversor;
  final bool isActivo;

  Inversor({
    required this.id,
    required this.nombreInversor,
    required this.isActivo,
  });

  factory Inversor.fromJson(Map<String, dynamic> json) {
    return Inversor(
      id: json['id'] ?? '',
      nombreInversor: json['nombreInversor'] ?? '',
      isActivo: json['IsActivo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreInversor': nombreInversor,
      'IsActivo': isActivo,
    };
  }
}
