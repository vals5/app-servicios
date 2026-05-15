class Solicitud {
  final String id;

  final String clienteNombre;
  final String clienteZona;
  final double clienteRating;
  final int clienteTrabajos;
  final bool clienteVerificado;

  final String categoria;       
  final double distanciaKm;
  final int minutosAtras;
  final String descripcion;     
  final String estimacionIA;   

  final double? precio;
  final String? diaVisita;
  final String? franjaHoraria;
  final String? direccion;

  const Solicitud({
    required this.id,
    required this.clienteNombre,
    required this.clienteZona,
    required this.clienteRating,
    required this.clienteTrabajos,
    required this.clienteVerificado,
    required this.categoria,
    required this.distanciaKm,
    required this.minutosAtras,
    required this.descripcion,
    required this.estimacionIA,
    this.precio,
    this.diaVisita,
    this.franjaHoraria,
    this.direccion,
  });

  Solicitud copyWith({
    double? precio,
    String? diaVisita,
    String? franjaHoraria,
    String? direccion,
  }) {
    return Solicitud(
      id: id,
      clienteNombre: clienteNombre,
      clienteZona: clienteZona,
      clienteRating: clienteRating,
      clienteTrabajos: clienteTrabajos,
      clienteVerificado: clienteVerificado,
      categoria: categoria,
      distanciaKm: distanciaKm,
      minutosAtras: minutosAtras,
      descripcion: descripcion,
      estimacionIA: estimacionIA,
      precio: precio ?? this.precio,
      diaVisita: diaVisita ?? this.diaVisita,
      franjaHoraria: franjaHoraria ?? this.franjaHoraria,
      direccion: direccion ?? this.direccion,
    );
  }
}