import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/crear_tarea.dart';
import 'package:app/vistas/registrar_estudiante.dart';
import 'package:app/vistas/seguimiento_estudiante.dart';
import 'package:app/vistas/ver_estudiantes.dart';
import 'package:app/vistas/ver_tareas.dart';
import 'package:app/vistas/ver_tareas_asignadas.dart';
import 'package:app/vistas/asignar_tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
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
                        Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
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
                        Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
                        listaTareas.add(tareaAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  List<Estudiante> listaEstudiantes = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
                    final response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var estudiantesJSON = json.decode(response.body);
                      for (var estudiante in estudiantesJSON) {
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  Navigator.push( context, MaterialPageRoute(builder: (context) => AsignarTarea(listaTareas, listaEstudiantes)));
                },
                child: Text("Asignar tarea"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () async {
                  List<TareaAsignada> tareasAsignadas = [];
                  List<Tarea> listaTareas = [];
                  List<Estudiante> listaEstudiantes = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas_asignadas.php";
                    var response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var tareasJSON = json.decode(response.body);
                      for (var tarea in tareasJSON) {
                        TareaAsignada tareaAux = new TareaAsignada(tarea['id_tarea'], tarea['id_estudiante'], tarea['fecha_inicio'], tarea['fecha_fin'], tarea['completada'], tarea['calificacion']);
                        tareasAsignadas.add(tareaAux);
                      }
                    }

                    uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas.php";
                    response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var tareasJSON = json.decode(response.body);
                      for (var tarea in tareasJSON) {
                        List<String> listaPasos = (jsonDecode( tarea['pasos']) as List<dynamic>).cast<String>();
                        Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
                        listaTareas.add(tareaAux);
                      }
                    }

                    uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
                    response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var estudiantesJSON = json.decode(response.body);
                      for (var estudiante in estudiantesJSON) {
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  Navigator.push( context, MaterialPageRoute(builder: (context) => VerTareasAsignadas(tareasAsignadas, listaTareas, listaEstudiantes)));
                },
                child: Text("Marcar tarea como completada"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () async {
                  List<Estudiante> listaEstudiantes = [];
                  List<Tarea> listaTareas = [];
                  List<TareaAsignada> tareasAsignadas = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
                    var response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var estudiantesJSON = json.decode(response.body);
                      for (var estudiante in estudiantesJSON) {
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }

                    uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas.php";
                    response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var tareasJSON = json.decode(response.body);
                      for (var tarea in tareasJSON) {
                        List<String> listaPasos = (jsonDecode( tarea['pasos']) as List<dynamic>).cast<String>();
                        Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
                        listaTareas.add(tareaAux);
                      }
                    }

                    uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas_asignadas.php";
                    response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var tareasJSON = json.decode(response.body);
                      for (var tarea in tareasJSON) {
                        TareaAsignada tareaAux = new TareaAsignada(tarea['id_tarea'], tarea['id_estudiante'], tarea['fecha_inicio'], tarea['fecha_fin'], tarea['completada'], tarea['calificacion']);
                        tareasAsignadas.add(tareaAux);
                      }
                    }

                  } catch (e) {
                    print("Exception: $e");
                  }
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SeguimientoEstudiante(listaEstudiantes, listaTareas, tareasAsignadas)));
                },
                child: Text("Seguimiento estudiantes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
