import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/elegir_usuario.dart';
import 'package:app/vistas/profesor/crear_tarea.dart';
import 'package:app/vistas/profesor/inicio_profesor.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


void main() => runApp(const MyApp());

Estudiante Alberto=Estudiante("1000", "Alberto", "PG", "alberto@gmail.com", "acceso", "si", "1234", "foto.jpg");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      CrearTarea()
      //InicioEstudiantePictograma(Alberto),
      //MyApp(),
    );
  }
}