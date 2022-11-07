import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/vistas/modificar_tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Tarea> listaTareas = [];

class VerTareas extends StatefulWidget {
  VerTareas(List<Tarea> tareas) {
    listaTareas.clear();
    listaTareas.addAll(tareas);
  }


  @override
  _VerTareasState createState() => _VerTareasState();
}

class _VerTareasState extends State<VerTareas> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  Future<void> borrarTarea(Tarea tarea) async {
    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/borrar_tarea.php";

      final response = await http.post(Uri.parse(uri), body: {
        "nombre": tarea.nombre
      });

      setState(() {
        listaTareas.remove(tarea);
      });
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> actualizarListaTareas() async {
    try {
      String uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas.php";
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          listaTareas.clear();
          var tareasJSON = json.decode(response.body);
          for (var tarea in tareasJSON) {
            List<String> listaPasos = (jsonDecode( tarea['pasos']) as List<dynamic>).cast<String>();
            Tarea tareaAux = new Tarea(tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaPasos);
            listaTareas.add(tareaAux);
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
            children: listaTareas.map((tarea) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(separacionElementos),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tarea.nombre),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ModificarTarea(tarea))).then((value) {
                                  actualizarListaTareas();
                                });
                              },
                              icon: Icon(Icons.edit)
                          ),
                          IconButton(
                              onPressed: () {
                                borrarTarea(tarea);
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
    );
  }
}
