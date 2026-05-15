// lib/providers/cliente_provider.dart
// Provider central del flujo cliente
// Etapa 2: datos mock — Etapa 3: reemplazar con llamadas a Supabase

import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../models/presupuesto.dart';

class ClientProvider extends ChangeNotifier {

  // ══════════════════════════════════════════
  // ESTADO
  // ══════════════════════════════════════════

  // Cliente logueado
  Cliente _cliente = const Cliente(
    id: 'cli_1',
    nombre: 'María López',
    zona: 'Godoy Cruz',
    rating: 4.8,
    cantTrabajos: 7,
    verificado: true,
    porcentajePerfil: 80,
  );

  // Presupuestos recibidos (pendientes de respuesta)
  List<Presupuesto> _presupuestos = [
    const Presupuesto(
      id: 'p1',
      profesionalId: 'prof_1',
      profesionalNombre: 'Leonardo Giménez',
      profesionalCategoria: 'Electricista',
      profesionalRating: 4.8,
      profesionalTrabajos: 23,
      descripcion: 'Cambio de térmica y revisión de tablero eléctrico.',
      precioMin: 12000,
      precioMax: 18000,
      diaVisita: '12 de marzo',
      franjaHoraria: '15:30 hs',
      direccion: 'Barrio Los Alerces, Godoy Cruz',
      montoSena: 1800,
      saldoPendiente: 10200,
      estado: EstadoPresupuesto.pendiente,
    ),
  ];

  Presupuesto? _presupuestoActivo;

  final List<Presupuesto> _historial = [];

  Cliente get cliente => _cliente;
  List<Presupuesto> get presupuestos => _presupuestos;
  Presupuesto? get presupuestoActivo => _presupuestoActivo;
  List<Presupuesto> get historial => _historial;

  Presupuesto? get presupuestoPendiente => _presupuestos
      .where((p) => p.estado == EstadoPresupuesto.pendiente)
      .isNotEmpty
      ? _presupuestos.firstWhere((p) => p.estado == EstadoPresupuesto.pendiente)
      : null;

  void seleccionarPresupuesto(Presupuesto presupuesto) {
    _presupuestoActivo = presupuesto;
    notifyListeners();
  }

  void aceptarPresupuesto(String id) {
    _actualizarEstado(id, EstadoPresupuesto.aceptado);
  }

  void pagarSena(String id) {
    _actualizarEstado(id, EstadoPresupuesto.pagado);
  }

  void profesionalEnDomicilio(String id) {
    _actualizarEstado(id, EstadoPresupuesto.enCurso);
  }

  void recibirMontoFinal(String id, double precioFinal) {
    final index = _presupuestos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _presupuestos[index] = _presupuestos[index].copyWith(
        estado: EstadoPresupuesto.finalizado,
        precioFinal: precioFinal,
        saldoPendiente: precioFinal - _presupuestos[index].montoSena,
      );
      _presupuestoActivo = _presupuestos[index];
      notifyListeners();
    }
  }

  void confirmarPagoFinal(String id) {
    _actualizarEstado(id, EstadoPresupuesto.cobrado);
    // Mueve al historial
    final p = _presupuestos.firstWhere((p) => p.id == id);
    _historial.add(p);
    _presupuestos.removeWhere((p) => p.id == id);
    _presupuestoActivo = null;
    notifyListeners();
  }

  void enviarReclamo(String id) {
    notifyListeners();
  }

  void _actualizarEstado(String id, EstadoPresupuesto nuevoEstado) {
    final index = _presupuestos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _presupuestos[index] = _presupuestos[index].copyWith(estado: nuevoEstado);
      _presupuestoActivo = _presupuestos[index];
      notifyListeners();
    }
  }
}