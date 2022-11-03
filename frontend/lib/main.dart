import 'package:app/asignar_tarea.dart';
import 'package:app/crear_tarea.dart';
import 'package:app/inicio_profesor.dart';
import 'package:app/modificar_tarea.dart';
import 'package:app/registrar_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:app/marcar_tarea_completada.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrarEstudiante(),
    );
  }
}