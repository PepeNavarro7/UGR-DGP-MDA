import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/profesor/datos_estudiante.dart';
import 'package:app/vistas/profesor/modificar_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Estudiante> listaEstudiantes = [];
List<Estudiante> listaTodosEstudiantes = [];

class VerEstudiantes extends StatefulWidget {
  VerEstudiantes(List<Estudiante> estudiantes) {
    listaEstudiantes.clear();
    listaEstudiantes.addAll(estudiantes);

    listaTodosEstudiantes.clear();
    listaTodosEstudiantes.addAll(estudiantes);
    print(listaTodosEstudiantes.length);
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
        "id_estudiante": estudiante.idEstudiante,
        "nombre": estudiante.nombre,
        "apellidos": estudiante.apellidos
      });

      print(response.body);

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
            Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario'], estudiante['foto']);
            listaEstudiantes.add(estudianteAux);
            listaTodosEstudiantes.add(estudianteAux);
          }
        });
      }
    } catch (e) {
      print("Exception: $e");
    }

  }

  void filtrarEstudiantes(String text) {
    List<Estudiante> aux = [];
    aux.addAll(listaTodosEstudiantes);
    setState(() {
      if (text.trim() != "")
        for(Estudiante e in listaEstudiantes) 
          if(!e.nombre.toUpperCase().contains(text.toUpperCase()))
            aux.remove(e);
    });
    listaEstudiantes = aux;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Ver Estudiantes", style: TextStyle(fontSize: 30)),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: TextField(
                onChanged: (text) {
                  filtrarEstudiantes(text);
                },
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Búsqueda",
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: listaEstudiantes.map((estudiante) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(separacionElementos),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(estudiante.nombre + " " + estudiante.apellidos, style: TextStyle(fontSize: 30)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => DatosEstudiante(estudiante)));
                                  },
                                  icon: Icon(Icons.remove_red_eye, size: 50),
                                ),

                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ModificarEstudiante(estudiante))).then((value) {
                                      actualizarListaEstudiantes();
                                    });
                                  },
                                  icon: Icon(Icons.edit, size: 50)
                                ),
                                IconButton(
                                    onPressed: () {
                                      borrarEstudiante(estudiante);
                                    },
                                    icon: Icon(Icons.delete, size: 50)
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}