import 'package:app/vistas/asignar_tarea.dart';
import 'package:app/vistas/crear_tarea.dart';
import 'package:app/vistas/inicio_profesor.dart';
import 'package:app/vistas/modificar_tarea.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:app/vistas/marcar_tarea_completada.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MarcarTareaCompletada(),
    );
  }
}