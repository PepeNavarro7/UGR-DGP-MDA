import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:flutter/material.dart';

List<Estudiante> listaEstudiantes = [];

class VerEstudiantes extends StatefulWidget {
  VerEstudiantes(List<Estudiante> estudiantes) {
    listaEstudiantes.addAll(estudiantes);
  }

  @override
  _VerEstudiantesState createState() => _VerEstudiantesState();
}

class _VerEstudiantesState extends State<VerEstudiantes> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Ver Estudiantes"),
      ),
      body: SafeArea(
        child: ListView(
          children: listaEstudiantes.map((estudiante) {
            return Text(estudiante.nombre);
          }).toList()
        ),
      )
    );
  }
}
