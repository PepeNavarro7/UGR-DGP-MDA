import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/estudiante/ver_tareas_estudiantes.dart';
import 'package:app/vistas/profesor/ver_grafica_seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;





class InicioEstudiantePictograma extends StatefulWidget {
  // El objeto _estudiante es miembro de la clase InicioEstudiante, para poder utilizarlo
  final Estudiante _estudiante;
  InicioEstudiantePictograma (this._estudiante); // Este es el constructor
  Estudiante getEstudiante(){
    return this._estudiante;
  }

  List<TareaAsignada> filtrarTareas(List<TareaAsignada> ta) {
    List<TareaAsignada> aux = [];
    for (int i = 0; i < ta.length; i++)
      if (ta[i].idEstudiante == _estudiante.idEstudiante)
        aux.add(ta[i]);

    return aux;
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
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
                      Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], tarea['materiales'], listaPasos);
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

                List<TareaAsignada> tareasEstudiante = inicioEstudiante.filtrarTareas(tareasAsignadas);

                Navigator.push( context, MaterialPageRoute(builder: (context) => VerTareasEstudiante(tareasEstudiante, listaTareas, inicioEstudiante.getEstudiante())), );
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height / 3.75,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Ver mis tareas",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    Icon(Icons.task_rounded,color: Colors.white, size: 40),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                List<Tarea> listaTareas = [];

                try {
                  String uri = "http://10.0.2.2/dgp_php_scripts/obtener_tareas.php";
                  var response = await http.get(Uri.parse(uri));

                  if (response.statusCode == 200) {
                    var tareasJSON = json.decode(response.body);
                    for (var tarea in tareasJSON) {
                      List<String> listaPasos = (jsonDecode( tarea['pasos']) as List<dynamic>).cast<String>();
                      Tarea tareaAux = new Tarea(tarea['id_tarea'], tarea['nombre'], tarea['descripcion'], tarea['lugar'], tarea['tipo'], tarea['materiales'], listaPasos);
                      listaTareas.add(tareaAux);
                    }
                  }
                } catch (e) {
                  print("Exception: $e");
                }

                //Navigator.push( context, MaterialPageRoute(builder: (context) => GraficaSeguimiento(inicioEstudiante.getEstudiante(), listaTareas)));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height / 3.75,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Perfil y estadísticas",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    Icon(Icons.face,color: Colors.white, size: 40),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height / 3.75,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Cerrar sesión",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    Icon(Icons.logout,color: Colors.white, size: 40),
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
