class Profesional {
  final String id;
  final String nombre;
  final String categoria;     
  final double rating;
  final int cantTrabajos;
  final String nivel;         
  final bool disponible;
  final double gananciaHoy;
  final double saldoDisponible;
  final int porcentajePerfil; 

  const Profesional({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.rating,
    required this.cantTrabajos,
    required this.nivel,
    required this.disponible,
    required this.gananciaHoy,
    required this.saldoDisponible,
    required this.porcentajePerfil,
  });

  Profesional copyWith({
    bool? disponible,
    double? gananciaHoy,
    double? saldoDisponible,
    int? porcentajePerfil,
  }) {
    return Profesional(
      id: id,
      nombre: nombre,
      categoria: categoria,
      rating: rating,
      cantTrabajos: cantTrabajos,
      nivel: nivel,
      disponible: disponible ?? this.disponible,
      gananciaHoy: gananciaHoy ?? this.gananciaHoy,
      saldoDisponible: saldoDisponible ?? this.saldoDisponible,
      porcentajePerfil: porcentajePerfil ?? this.porcentajePerfil,
    );
  }
}