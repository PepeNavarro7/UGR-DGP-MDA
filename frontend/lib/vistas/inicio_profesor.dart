import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/crear_tarea.dart';
import 'package:app/vistas/modificar_tarea.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:app/vistas/ver_estudiantes.dart';
import 'package:app/vistas/ver_tareas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../clases/tarea.dart';

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
        title: Text("Colegio San Rafael"),
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

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () async {
                  List<Estudiante> listaEstudiantes = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
                    final response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var estudiantesJSON = json.decode(response.body);
                      for (var estudiante in estudiantesJSON) {
                        Estudiante estudianteAux = new Estudiante(estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  Navigator.push( context, MaterialPageRoute(builder: (context) => VerEstudiantes(listaEstudiantes) ), );
                },
                child: Text("Ver estudiantes"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => CrearTarea()), );
                },
                child: Text("Crear tarea"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () async {
                  List<Tarea> listaTareas = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas.php";
                    final response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var tareasJSON = json.decode(response.body);
                      for (var tarea in tareasJSON) {
                        List<String> listaPasos = (jsonDecode( tarea['pasos']) as List<dynamic>).cast<String>();
                        Tarea tareaAux = new Tarea(tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
                        listaTareas.add(tareaAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  Navigator.push( context, MaterialPageRoute(builder: (context) => VerTareas(listaTareas)));
                },
                child: Text("Ver tareas"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
