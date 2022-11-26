import 'package:app/clases/estudiante.dart';
import 'package:flutter/material.dart';

Estudiante? estudiante;

class DatosEstudiante extends StatefulWidget {
  DatosEstudiante(Estudiante e) {
    estudiante = e;
  }


  @override
  State<DatosEstudiante> createState() => _DatosEstudianteState();
}

class _DatosEstudianteState extends State<DatosEstudiante> {
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
        title: Text("Datos del estudiante"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 250,
              width: 250,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: CircleAvatar(backgroundImage: NetworkImage("http://10.0.2.2/" + estudiante!.foto.substring(3))),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Nombre: " + estudiante!.nombre),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Apellidos: " + estudiante!.apellidos),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Email: " + estudiante!.email),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Acceso: " + estudiante!.acceso),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Necesidades del estudiante: " + estudiante!.accesibilidad),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Text("Contraseña: " + estudiante!.password),
            )
          ],
        ),
      ),
    );
  }
}