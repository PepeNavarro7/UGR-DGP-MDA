import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<TareaAsignada> listaTareasAsignadas = [];
List<Tarea> listaTareas = [];
Estudiante? estudiante;

class VerTareasEstudiante extends StatefulWidget {
  VerTareasEstudiante(List<TareaAsignada> tareasAsignadas, List<Tarea> tareas, Estudiante e) {
    listaTareasAsignadas.clear();
    listaTareasAsignadas.addAll(tareasAsignadas);

    listaTareas.clear();
    listaTareas.addAll(tareas);

    estudiante = e;
  }

  @override
  _VerTareasEstudianteState createState() => _VerTareasEstudianteState();
}

class _VerTareasEstudianteState extends State<VerTareasEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  int indiceDeTarea(String idTarea) {
    int indice = -1;

    for(Tarea tarea in listaTareas)
      if (tarea.idTarea == idTarea)
        indice = listaTareas.indexOf(tarea);

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
        title: Text("Tareas de " + estudiante!.nombre),
      ),
      body: SafeArea(
        child: ListView(
            children: listaTareasAsignadas.map((tareaAsignada) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(separacionElementos),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tarea: " + listaTareas[indiceDeTarea(tareaAsignada.idTarea)].nombre),
                      Text("Tipo: " + tipoAString(listaTareas[indiceDeTarea(tareaAsignada.idTarea)].tipo)),
                      Text(tareaAsignada.completada == "0" ? "No completada" : "Completada"),
                      Text("Evaluación: " + tareaAsignada.calificacion),
                    ],
                  ),
                ),
              );
            }).toList()
        ),
      ),
    );
  }

  String tipoAString(String tipo) {
    String aux = "";
    if (tipo.contains("N"))
      aux = "Normal";
    else if (tipo.contains("C"))
      aux = "Comanda";
    else if (tipo.contains("M"))
      aux = "Menú";

    return aux;
  }
}
