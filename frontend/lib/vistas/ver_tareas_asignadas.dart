import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/asignar_tarea.dart';
import 'package:app/vistas/marcar_tarea_completada.dart';
import 'package:app/vistas/modificar_tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<TareaAsignada> listaTareasAsignadas = [];
List<Tarea> listaTareas = [];
List<Estudiante> listaEstudiante = [];

class VerTareasAsignadas extends StatefulWidget {
  VerTareasAsignadas(List<TareaAsignada> tareasAsignadas, List<Tarea> tareas, List<Estudiante> estudiantes) {
    listaTareasAsignadas.clear();
    listaTareasAsignadas.addAll(tareasAsignadas);

    listaTareas.clear();
    listaTareas.addAll(tareas);

    listaEstudiantes.clear();
    listaEstudiantes.addAll(estudiantes);
  }

  @override
  _VerTareasAsignadasState createState() => _VerTareasAsignadasState();
}

class _VerTareasAsignadasState extends State<VerTareasAsignadas> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  int indiceDeTarea(String idTarea) {
    int indice = -1;

    for(Tarea tarea in listaTareas)
      if (tarea.id_tarea == idTarea)
        indice = listaTareas.indexOf(tarea);

    return indice;
  }

  int indiceDeEstudiante(String idEstudiante) {
    int indice = -1;

    for(Estudiante estudiante in listaEstudiantes)
      if (estudiante.id_estudiante == idEstudiante)
        indice = listaEstudiantes.indexOf(estudiante);

    return indice;
  }

  Future<void> actualizarListaTareasAsignadas() async {
    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas_asignadas.php";
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          listaTareasAsignadas.clear();
          var tareasJSON = json.decode(response.body);
          for (var tarea in tareasJSON) {
            TareaAsignada tareaAux = new TareaAsignada(tarea['id_tarea'], tarea['id_estudiante'], tarea['fecha_inicio'], tarea['fecha_fin'], tarea['completada'], tarea['calificacion']);
            listaTareasAsignadas.add(tareaAux);
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
        title: Text("Ver Tareas"),
      ),
      body: SafeArea(
        child: ListView(
            children: listaTareasAsignadas.map((tareaAsignada) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MarcarTareaCompletada(tareaAsignada, listaTareas[indiceDeTarea(tareaAsignada.id_tarea)], listaEstudiantes[indiceDeEstudiante(tareaAsignada.id_estudiante)]))).then((value) {
                    actualizarListaTareasAsignadas();
                  });
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(separacionElementos),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tarea: " + listaTareas[indiceDeTarea(tareaAsignada.id_tarea)].nombre),
                        Text("Estudiantes: " + listaEstudiantes[indiceDeEstudiante(tareaAsignada.id_estudiante)].nombre),
                        Text(tareaAsignada.completada == "0" ? "No completada" : "Completada"),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()
        ),
      ),
    );
  }
}
