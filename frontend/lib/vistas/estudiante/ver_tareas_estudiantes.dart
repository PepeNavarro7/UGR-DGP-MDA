import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/material.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/estudiante/tareas_estudiante.dart';
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

  Widget Tareas() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.85,
      color: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffffff50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                List<TareaAsignada> tareasAsignadas = [];
                List<Tarea> listaTareas = [];

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

                      List<MaterialComanda> listaMateriales = [];
                      List<String> listaMaterialesString = (jsonDecode( tarea['materiales']) as List<dynamic>).cast<String>();

                      for (int i = 0; i < listaMaterialesString.length; i++) {
                        MaterialComanda aux = MaterialComanda(listaMaterialesString[i].split(" ")[0], listaMaterialesString[i].split(" ")[1]);
                        listaMateriales.add(aux);
                      }

                      Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaMateriales, listaPasos);
                      listaTareas.add(tareaAux);
                    }
                  }
                } catch (e) {
                  print("Exception: $e");
                }

                List<Tarea> aux = [];

                listaTareas.forEach((element) {
                  int indice = 0;
                  for (TareaAsignada ta in listaTareasAsignadas) {
                    if (ta.idTarea == element.idTarea)
                      indice = listaTareasAsignadas.indexOf(ta);
                  }

                  if(element.tipo == "N" && listaTareasAsignadas[indice].idEstudiante == estudiante!.idEstudiante)
                    aux.add(element);
                });

                Navigator.push( context, MaterialPageRoute(builder: (context) => TareasEstudiante(aux)));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(child: Text("TAREAS",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)))
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset("assets/imagenes/tarea.png")
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                List<TareaAsignada> tareasAsignadas = [];
                List<Tarea> listaTareas = [];

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

                      List<MaterialComanda> listaMateriales = [];
                      List<String> listaMaterialesString = (jsonDecode( tarea['materiales']) as List<dynamic>).cast<String>();

                      for (int i = 0; i < listaMaterialesString.length; i++) {
                        MaterialComanda aux = MaterialComanda(listaMaterialesString[i].split(" ")[0], listaMaterialesString[i].split(" ")[1]);
                        listaMateriales.add(aux);
                      }

                      Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaMateriales, listaPasos);
                      listaTareas.add(tareaAux);
                    }
                  }
                } catch (e) {
                  print("Exception: $e");
                }

                List<Tarea> aux = [];

                listaTareas.forEach((element) {
                  int indice = 0;
                  for (TareaAsignada ta in listaTareasAsignadas) {
                    if (ta.idTarea == element.idTarea)
                      indice = listaTareasAsignadas.indexOf(ta);
                  }

                  if(element.tipo == "C" && listaTareasAsignadas[indice].idEstudiante == estudiante!.idEstudiante)
                    aux.add(element);
                });

                Navigator.push( context, MaterialPageRoute(builder: (context) => TareasEstudiante(aux)));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(child: Text("COMANDA",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)))
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.all(10),
                        child: Image.asset("assets/imagenes/comanda.png")
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                List<TareaAsignada> tareasAsignadas = [];
                List<Tarea> listaTareas = [];

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

                      List<MaterialComanda> listaMateriales = [];
                      List<String> listaMaterialesString = (jsonDecode( tarea['materiales']) as List<dynamic>).cast<String>();

                      for (int i = 0; i < listaMaterialesString.length; i++) {
                        MaterialComanda aux = MaterialComanda(listaMaterialesString[i].split(" ")[0], listaMaterialesString[i].split(" ")[1]);
                        listaMateriales.add(aux);
                      }

                      Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], listaMateriales, listaPasos);
                      listaTareas.add(tareaAux);
                    }
                  }
                } catch (e) {
                  print("Exception: $e");
                }

                List<Tarea> aux = [];

                listaTareas.forEach((element) {
                  int indice = 0;
                  for (TareaAsignada ta in listaTareasAsignadas) {
                    if (ta.idTarea == element.idTarea)
                      indice = listaTareasAsignadas.indexOf(ta);
                  }

                  if(element.tipo == "M" && listaTareasAsignadas[indice].idEstudiante == estudiante!.idEstudiante)
                    aux.add(element);
                });

                Navigator.push( context, MaterialPageRoute(builder: (context) => TareasEstudiante(aux)));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(child: Text("MENÚS",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)))
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.all(10),
                        child: Image.asset("assets/imagenes/menu.png")
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(child: Text("VOLVER",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)))
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.all(10),
                        child: Image.asset("assets/imagenes/salir.png")
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
