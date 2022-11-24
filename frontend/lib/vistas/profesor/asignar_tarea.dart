import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  FToast ventana_mensajes = FToast();

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

  int indiceDeTarea(String nombre) {
    int indice = -1;

    for (int i = 0; i < listaTareas.length; i++)
      if (listaTareas[i].nombre == nombre)
        indice = i;

    return indice;
  }

  int indiceDeEstudiante(String nombre) {
    int indice = -1;

    for (int i = 0; i < listaEstudiantes.length && indice == -1; i++)
      if (listaEstudiantes[i].nombre == nombre)
        indice = i;

    return indice;
  }

  Future<void> asignarTarea() async {
    if (datosCompletos()) {
      ventana_mensajes.init(context);
      print("idTarea: " + tarea.idTarea);
      print("idEstudiante: " + estudiante.idEstudiante);
      print("fechaInicio: $fechaInicio");
      print("fechaFin: $fechaFin");

      try {
        String uri = "http://10.0.2.2/dgp_php_scripts/asignar_tarea_estudiante.php";

        final response = await http.post(Uri.parse(uri), body: {
          "id_tarea": tarea.idTarea,
          "id_estudiante": estudiante.idEstudiante,
          "fecha_inicio": fechaInicio,
          "fecha_fin": fechaFin,
          "completada": "0",
          "calificacion": "Pendiente",
        });

        print("Tarea asignada a estudiante");
        FToast().showToast(
            child: Text("Tarea asignada",
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
        );
        Navigator.pop(context);

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
