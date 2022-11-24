import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/profesor/asignar_tarea.dart';
import 'package:app/vistas/profesor/crear_tarea.dart';
import 'package:app/vistas/profesor/inicio_profesor.dart';
import 'package:app/vistas/profesor/modificar_estudiante.dart';
import 'package:app/vistas/profesor/modificar_tarea.dart';
import 'package:app/vistas/estudiante/pagina_login_estudiante.dart';
import 'package:app/vistas/profesor/registrar_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:app/vistas/profesor/marcar_tarea_completada.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InicioProfesor(),
    );
  }
}