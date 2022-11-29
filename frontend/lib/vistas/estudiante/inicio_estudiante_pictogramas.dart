import 'dart:convert';
import 'dart:ffi';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/elegir_usuario.dart';
import 'package:app/vistas/estudiante/inicio_sesion_estudiante.dart';
import 'package:app/vistas/profesor/ver_tareas_asignadas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../profesor/registrar_estudiante.dart';
import '../profesor/ver_tareas.dart';

import '../estudiante/ver_mi_perfil_estudiante.dart';





class InicioEstudiantePictograma extends StatefulWidget {
  // El objeto _estudiante es miembro de la clase InicioEstudiante, para poder utilizarlo
  final Estudiante _estudiante;
  InicioEstudiantePictograma (this._estudiante); // Este es el constructor
  Estudiante getEstudiante(){
    return this._estudiante;
  }



  // De igual manera, paso el "this" al _InicioEstudianteState, para que pueda acceder a InicioEstudiante
  // y poder llamar a getEstudiante
  @override
  _InicioEstudiantePictogramaState createState() => _InicioEstudiantePictogramaState(this);

}

class _InicioEstudiantePictogramaState extends State<InicioEstudiantePictograma> {
  // De forma analoga, la clase "state" tiene como objeto miembro a la clase general, para poder llamarla
  final InicioEstudiantePictograma inicioEstudiante;
  _InicioEstudiantePictogramaState(this.inicioEstudiante);
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 60.0;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text(inicioEstudiante.getEstudiante().nombre+" "+inicioEstudiante.getEstudiante().apellidos,style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child:


              ElevatedButton(
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
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario'], estudiante['foto']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }
                  Navigator.push( context, MaterialPageRoute(builder: (context) => VerTareasAsignadas(tareasAsignadas, listaTareas, listaEstudiantes)), );
                },
                child: Row(
                  children: [
                    Text("        Ver mis tareas    ",style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.directions_walk,color: Colors.white),
                  ],
                ),
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
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario'], estudiante['foto']);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  //Navigator.push( context, MaterialPageRoute(builder: (context) => VerEstudiantes(listaEstudiantes) ), );
                },
                child:
                  Row(
                    children: [
                      Text("        Ver mis comandas ",style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.task_rounded,color: Colors.white),
                    ],
                  ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.push( context, MaterialPageRoute(builder: (context) => VerMiPerfilEstudiante()), );
                },
                child:
                  Row(
                    children: [
                      Text("      Perfil y estadísticas ",style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.face,color: Colors.white),
                    ],
                  ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  // Background color
                ),
                child:
                  Row(
                    children: [
                      Text("                LOG OUT   ",style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.logout,color: Colors.white),
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
