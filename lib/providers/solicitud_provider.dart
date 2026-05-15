import 'package:flutter/material.dart';
import '../models/solicitud.dart';
import '../models/trabajo.dart';
import '../models/profesional.dart';

class SolicitudProvider extends ChangeNotifier {

  Profesional _profesional = const Profesional(
    id: 'prof_1',
    nombre: 'Leonardo',
    categoria: 'Electricista',
    rating: 4.8,
    cantTrabajos: 23,
    nivel: 'Plata',
    disponible: true,
    gananciaHoy: 18500,
    saldoDisponible: 32500,
    porcentajePerfil: 40,
  );

  final List<Solicitud> _solicitudes = [
    const Solicitud(
      id: 's1',
      clienteNombre: 'María López',
      clienteZona: 'Godoy Cruz',
      clienteRating: 4.8,
      clienteTrabajos: 7,
      clienteVerificado: true,
      categoria: 'Electricidad',
      distanciaKm: 1.2,
      minutosAtras: 3,
      descripcion: 'Se cortó la luz en cocina y saltó la térmica.',
      estimacionIA: 'Diagnóstico eléctrico domiciliario.',
      direccion: 'Barrio Los Alerces, Godoy Cruz',
    ),
    const Solicitud(
      id: 's2',
      clienteNombre: 'Carlos Ruiz',
      clienteZona: 'Maipú',
      clienteRating: 4.5,
      clienteTrabajos: 12,
      clienteVerificado: false,
      categoria: 'Plomería',
      distanciaKm: 2.5,
      minutosAtras: 8,
      descripcion: 'Pérdida de agua debajo del lavatorio.',
      estimacionIA: 'Revisión y reemplazo de sifón.',
      direccion: 'Dorrego, Maipú',
    ),
  ];

  Solicitud? _solicitudSeleccionada;
  Trabajo? _trabajoActivo;
  final List<Trabajo> _historial = [];

  Profesional get profesional => _profesional;
  List<Solicitud> get solicitudes => _solicitudes;
  Solicitud? get solicitudActiva => _solicitudes.isNotEmpty ? _solicitudes.first : null;
  Solicitud? get solicitudSeleccionada => _solicitudSeleccionada;
  Trabajo? get trabajoActivo => _trabajoActivo;
  List<Trabajo> get historial => _historial;

  void seleccionarSolicitud(Solicitud solicitud) {
    _solicitudSeleccionada = solicitud;
    notifyListeners();
  }

  void rechazarSolicitud(String id) {
    _solicitudes.removeWhere((s) => s.id == id);
    _solicitudSeleccionada = null;
    notifyListeners();
  }

  void completarPresupuesto({
    required String id,
    required double precio,
    required String diaVisita,
    required String franjaHoraria,
  }) {
    final index = _solicitudes.indexWhere((s) => s.id == id);
    if (index != -1) {
      _solicitudes[index] = _solicitudes[index].copyWith(
        precio: precio,
        diaVisita: diaVisita,
        franjaHoraria: franjaHoraria,
      );
      _solicitudSeleccionada = _solicitudes[index];
    }
    notifyListeners();
  }

  void aceptarPresupuesto(Solicitud solicitud) {
    _trabajoActivo = Trabajo(
      id: 'job_${solicitud.id}',
      solicitud: solicitud,
      estado: EstadoTrabajo.aceptado,
    );
    _solicitudes.removeWhere((s) => s.id == solicitud.id);
    notifyListeners();
  }

  void iniciarTrabajo() {
    if (_trabajoActivo == null) return;
    _trabajoActivo = _trabajoActivo!.copyWith(
      estado: EstadoTrabajo.enDomicilio,
      horaInicio: DateTime.now(),
    );
    notifyListeners();
  }

  void pausarTrabajo() {
    if (_trabajoActivo == null) return;
    _trabajoActivo = _trabajoActivo!.copyWith(estado: EstadoTrabajo.enPausa);
    notifyListeners();
  }

  void finalizarTrabajo() {
    if (_trabajoActivo == null) return;
    _trabajoActivo = _trabajoActivo!.copyWith(
      estado: EstadoTrabajo.finalizado,
      horaFin: DateTime.now(),
    );
    notifyListeners();
  }

  void confirmarPago({required double monto, required String metodoPago}) {
    if (_trabajoActivo == null) return;
    _trabajoActivo = _trabajoActivo!.copyWith(
      estado: EstadoTrabajo.cobrado,
      montoFinal: monto,
      metodoPago: metodoPago,
    );
    _historial.add(_trabajoActivo!);
    _profesional = _profesional.copyWith(
      gananciaHoy: _profesional.gananciaHoy + monto,
      saldoDisponible: _profesional.saldoDisponible + monto,
    );
    _trabajoActivo = null;
    notifyListeners();
  }

  void toggleDisponible() {
    _profesional = _profesional.copyWith(disponible: !_profesional.disponible);
    notifyListeners();
  }
}