class Cliente {
  final String id;
  final String nombre;
  final String zona;
  final double rating;
  final int cantTrabajos;
  final bool verificado;
  final int porcentajePerfil;

  const Cliente({
    required this.id,
    required this.nombre,
    required this.zona,
    required this.rating,
    required this.cantTrabajos,
    required this.verificado,
    required this.porcentajePerfil,
  });

  Cliente copyWith({
    String? zona,
    double? rating,
    int? cantTrabajos,
    int? porcentajePerfil,
  }) {
    return Cliente(
      id: id,
      nombre: nombre,
      zona: zona ?? this.zona,
      rating: rating ?? this.rating,
      cantTrabajos: cantTrabajos ?? this.cantTrabajos,
      verificado: verificado,
      porcentajePerfil: porcentajePerfil ?? this.porcentajePerfil,
    );
  }
}