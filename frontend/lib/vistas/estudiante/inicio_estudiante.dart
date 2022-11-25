import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class InicioEstudiante extends StatefulWidget {
  // El objeto _estudiante es miembro de la clase InicioEstudiante, para poder utilizarlo
  final Estudiante _estudiante;
  InicioEstudiante (this._estudiante); // Este es el constructor
  Estudiante getEstudiante(){
    return this._estudiante;
  }

  // De igual manera, paso el "this" al _InicioEstudianteState, para que pueda acceder a InicioEstudiante
  // y poder llamar a getEstudiante
  @override
  _InicioEstudianteState createState() => _InicioEstudianteState(this);
}

class _InicioEstudianteState extends State<InicioEstudiante> {
  // De forma analoga, la clase "state" tiene como objeto miembro a la clase general, para poder llamarla
  final InicioEstudiante inicioEstudiante;
  _InicioEstudianteState(this.inicioEstudiante);
  // Color de la AppBar
  final colorAppBar = Colors.lightGreen;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Nombre del Estudiante"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => RegistrarEstudiante()), );
                },
                child: Text("Registrar estudiante"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
