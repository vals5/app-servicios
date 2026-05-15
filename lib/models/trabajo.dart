import 'solicitud.dart';

enum EstadoTrabajo {
  aceptado,     
  enCamino,     
  enDomicilio,  
  enPausa,      
  finalizado,   
  cobrado,      
}

class Trabajo {
  final String id;
  final Solicitud solicitud; 
  final EstadoTrabajo estado;
  final DateTime? horaInicio;
  final DateTime? horaFin;
  final double? montoFinal;   
  final String? metodoPago;  

  const Trabajo({
    required this.id,
    required this.solicitud,
    required this.estado,
    this.horaInicio,
    this.horaFin,
    this.montoFinal,
    this.metodoPago,
  });

  Duration? get duracion {
    if (horaInicio == null || horaFin == null) return null;
    return horaFin!.difference(horaInicio!);
  }

  String get duracionFormateada {
    final d = duracion;
    if (d == null) return '--:--:--';
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Trabajo copyWith({
    EstadoTrabajo? estado,
    DateTime? horaInicio,
    DateTime? horaFin,
    double? montoFinal,
    String? metodoPago,
  }) {
    return Trabajo(
      id: id,
      solicitud: solicitud,
      estado: estado ?? this.estado,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFin: horaFin ?? this.horaFin,
      montoFinal: montoFinal ?? this.montoFinal,
      metodoPago: metodoPago ?? this.metodoPago,
    );
  }
}
