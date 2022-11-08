import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Lista de tipo String que contiene todas las tareas
final List<Tarea> listaTareas = [];

// Lista de tipo String que contiene todos los estudiantes
final List<Estudiante> listaEstudiantes = [];

/*
 * Clase Asignar Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class AsignarTarea extends StatefulWidget {
  AsignarTarea(List<Tarea> _listaTareas, List<Estudiante> _listaEstudiantes) {
    listaTareas.clear();
    listaTareas.addAll(_listaTareas);
    listaEstudiantes.clear();
    listaEstudiantes.addAll(_listaEstudiantes);
  }

  @override
  _AsignarTareaState createState() => _AsignarTareaState();
}

class _AsignarTareaState extends State<AsignarTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Valor inicial del Dropdown de tareas
  Tarea tarea = listaTareas.first;

  // Valor inicial del Dropdown de estudiantes
  Estudiante estudiante = listaEstudiantes.first;

  // Fecha del inicio de la tarea
  String fechaInicio = "";

  // Fecha del fin de la tarea
  String fechaFin = "";

  // Función que devuelve el índice de la lista con la tarea del mismo nombre
  int indiceDeTarea(String nombre) {
    int indice = -1;

    for(int i = 0; i < listaTareas.length && indice == -1; i++)
      if (listaTareas[i].nombre == nombre)
        indice = i;

    return indice;
  }

  // Función que devuelve el índice de la lista con el estudiante del mismo nombre
  int indiceDeEstudiante(String nombre) {
    int indice = -1;

    for(int i = 0; i < listaEstudiantes.length && indice == -1; i++)
      if (listaEstudiantes[i].nombre == nombre)
        indice = i;

    return indice;
  }

  Future<String> obtenerIdTarea(Tarea tarea) async {
    String idTarea = "";

    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/obtener_id_tarea.php";

      final response = await http.post(Uri.parse(uri), body: {
        "nombre": tarea.nombre,
      });
      
      if (response.statusCode == 200) {
        var responseJSON = json.decode(response.body);
        for(var tarea in responseJSON)
          idTarea = tarea['id_tarea'];
      }
    } catch (e) {
      print("Exception: $e");
    }

    return idTarea;
  }

  Future<String> obtenerIdEstudiante(Estudiante estudiante) async {
    String idEstudiante = "";

    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/obtener_id_estudiante.php";

      final response = await http.post(Uri.parse(uri), body: {
        "nombre": estudiante.nombre,
        "apellidos": estudiante.apellidos,
        "email": estudiante.email
      });

      if (response.statusCode == 200) {
        var responseJSON = json.decode(response.body);
        for(var tarea in responseJSON)
          idEstudiante = tarea['id_estudiante'];
      }
    } catch (e) {
      print("Exception: $e");
    }

    return idEstudiante;
  }

  bool datosCompletos() {
    bool aux = true;
    if (tarea == null){
      aux=false;
    }
    if (estudiante == null){
      aux=false;
    }
    if (fechaInicio == ""){
      aux=false;
    }
    if (fechaFin == ""){
      aux=false;
    }
    return aux;
  }

  Future<void> asignarTarea() async {
    if (datosCompletos()) {
      String idTarea = await obtenerIdTarea(tarea);
      String idEstudiante = await obtenerIdEstudiante(estudiante);

      print("idTarea: $idTarea");
      print("idEstudiante: $idEstudiante");
      print("fechaInicio: $fechaInicio");
      print("fechaFin: $fechaFin");

      try {
        String uri = "http://10.0.2.2/dgp_php_scripts/asignar_tarea_estudiante.php";

        final response = await http.post(Uri.parse(uri), body: {
          "id_tarea": idTarea,
          "id_estudiante": idEstudiante,
          "fecha_inicio": fechaInicio,
          "fecha_fin": fechaFin,
          "completada": "0",
          "calificacion": "Pendiente",
        });

        print("Tarea asignada a estudiante");

      } catch (e) {
        print("Exception: $e");
      }
    } else {
      print("Faltan datos");
    }
  }

  /*
   * Devuelve un Widget para mostrar el menú de Asignar Tarea, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre de la tarea (Dropdown)
   *    2. Nombre del alumno (Dropdown)
   *    3. Asignar (ElevatedButton)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Asignar Tarea"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: tarea.nombre,
                  isExpanded: true,
                  items: listaTareas.map<DropdownMenuItem<String>>((Tarea valor) {
                    return DropdownMenuItem<String>(
                      value: valor.nombre,
                      child: Text(valor.nombre),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      tarea = listaTareas[indiceDeTarea(valor!)];
                    });
                  },
                )
            ),

            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: estudiante.nombre,
                  isExpanded: true,
                  items: listaEstudiantes.map<DropdownMenuItem<String>>((Estudiante valor) {
                    return DropdownMenuItem<String>(
                      value: valor.nombre,
                      child: Text(valor.nombre),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      estudiante = listaEstudiantes[indiceDeEstudiante(valor!)];
                    });
                  },
                )
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                onChanged: (valor) {
                  fechaInicio = valor;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Fecha inicio",
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                onChanged: (valor) {
                  fechaFin = valor;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Fecha fin",
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: asignarTarea,
                child: Text("Asignar tarea"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
