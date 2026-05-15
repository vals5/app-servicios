enum EstadoPresupuesto {
  pendiente,    // El cliente aún no respondió
  aceptado,     // Cliente aceptó → fluye a confirmation/budget/payment
  rechazado,    // Cliente rechazó
  pagado,       // Seña pagada → payment_confirmed
  enCurso,      // Profesional en domicilio → status
  finalizado,   // Trabajo terminado → final_payment
  cobrado,      // Cliente pagó el total → fp_confirmed
}

class Presupuesto {
  final String id;

  // ── Datos del profesional ──
  final String profesionalId;
  final String profesionalNombre;
  final String profesionalCategoria;
  final double profesionalRating;
  final int profesionalTrabajos;

  // ── Datos del trabajo ──
  final String descripcion;
  final double precioMin;
  final double precioMax;
  final String diaVisita;
  final String franjaHoraria;
  final String direccion;

  // ── Seña ──
  final double montoSena;       // 15% del mínimo
  final double saldoPendiente;  // precioFinal - montoSena

  // ── Estado ──
  final EstadoPresupuesto estado;
  final double? precioFinal;    // Se confirma al finalizar el trabajo

  const Presupuesto({
    required this.id,
    required this.profesionalId,
    required this.profesionalNombre,
    required this.profesionalCategoria,
    required this.profesionalRating,
    required this.profesionalTrabajos,
    required this.descripcion,
    required this.precioMin,
    required this.precioMax,
    required this.diaVisita,
    required this.franjaHoraria,
    required this.direccion,
    required this.montoSena,
    required this.saldoPendiente,
    required this.estado,
    this.precioFinal,
  });

  Presupuesto copyWith({
    EstadoPresupuesto? estado,
    double? precioFinal,
    double? saldoPendiente,
  }) {
    return Presupuesto(
      id: id,
      profesionalId: profesionalId,
      profesionalNombre: profesionalNombre,
      profesionalCategoria: profesionalCategoria,
      profesionalRating: profesionalRating,
      profesionalTrabajos: profesionalTrabajos,
      descripcion: descripcion,
      precioMin: precioMin,
      precioMax: precioMax,
      diaVisita: diaVisita,
      franjaHoraria: franjaHoraria,
      direccion: direccion,
      montoSena: montoSena,
      saldoPendiente: saldoPendiente ?? this.saldoPendiente,
      estado: estado ?? this.estado,
      precioFinal: precioFinal ?? this.precioFinal,
    );
  }
}