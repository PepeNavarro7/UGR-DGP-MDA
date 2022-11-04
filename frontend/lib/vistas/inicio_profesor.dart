import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:app/vistas/ver_estudiantes.dart';
import 'package:flutter/material.dart';

class InicioProfesor extends StatefulWidget {
  @override
  _InicioProfesorState createState() => _InicioProfesorState();
}

class _InicioProfesorState extends State<InicioProfesor> {
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
        title: Text("Inicio Profesor"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrarEstudiante()),
                  );
                },
                child: Text("Registrar estudiante"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: () {
                  List<Estudiante> estudiantes = [];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerEstudiantes(estudiantes)),
                  );
                },
                child: Text("Ver estudiantes"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
