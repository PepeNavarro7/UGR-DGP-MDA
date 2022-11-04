import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/modificar_estudiante.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Estudiante> listaEstudiantes = [];

class VerEstudiantes extends StatefulWidget {
  VerEstudiantes(List<Estudiante> estudiantes) {
    listaEstudiantes.clear();
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

  Future<void> borrarEstudiante(Estudiante estudiante) async {
    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/borrar_estudiante.php";

      final response = await http.post(Uri.parse(uri), body: {
        "nombre": estudiante.nombre,
        "apellidos": estudiante.apellidos,
        "email": estudiante.email,
      });

      setState(() {
        listaEstudiantes.remove(estudiante);
      });
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> actualizarListaEstudiantes() async {
    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          listaEstudiantes.clear();
          var estudiantesJSON = json.decode(response.body);
          for (var estudiante in estudiantesJSON) {
            Estudiante estudianteAux = new Estudiante(estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
            listaEstudiantes.add(estudianteAux);
          }
        });
      }
    } catch (e) {
    print("Exception: $e");
    }
  }

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
            return Card(
              child: Container(
                padding: EdgeInsets.all(separacionElementos),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(estudiante.nombre + " " + estudiante.apellidos),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ModificarEstudiante(estudiante))).then((value) {
                              actualizarListaEstudiantes();
                            });
                          },
                          icon: Icon(Icons.edit)
                        ),
                        IconButton(
                            onPressed: () {
                              borrarEstudiante(estudiante);
                            },
                            icon: Icon(Icons.delete)
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          actualizarListaEstudiantes();
        },
        child: Icon(Icons.update),
      ),
    );
  }
}
