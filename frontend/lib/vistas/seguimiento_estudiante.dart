import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';

List<Estudiante> listaEstudiantes = [];
List<Tarea> listaTareas = [];
List<TareaAsignada> listaTareasAsignadas = [];
List<Tarea> listaTareasCompletadas = [];
List<Tarea> listaTareasNoCompletadas = [];

Estudiante? estudiante;

Estudiante buscarEstudiante(String nombre) {
  Estudiante e = listaEstudiantes.first;

  for (Estudiante eAux in listaEstudiantes)
    if (eAux.nombre == nombre)
      e = eAux;

  return e;
}

Tarea buscarTarea(String idTarea) {
  Tarea t = listaTareas.first;

  for (Tarea tAux in listaTareas)
    if(tAux.id_tarea == idTarea)
      t = tAux;

  return t;
}

void actualizarListaTareasCompletadas(Estudiante e) {
  listaTareasCompletadas.clear();

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "1" && ta.id_estudiante == e.id_estudiante)
      listaTareasCompletadas.add(buscarTarea(ta.id_tarea));
}

void actualizarListaTareasNoCompletadas(Estudiante e) {
  listaTareasNoCompletadas.clear();

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "0" && ta.id_estudiante == e.id_estudiante)
      listaTareasNoCompletadas.add(buscarTarea(ta.id_tarea));
}

/*
 * Clase Seguimiento hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class SeguimientoEstudiante extends StatefulWidget {
  SeguimientoEstudiante(List<Estudiante> estudiantes, List<Tarea> tareas, List<TareaAsignada> tareasAsignadas) {
    listaEstudiantes.clear();
    listaTareas.clear();
    listaTareasAsignadas.clear();

    listaEstudiantes.addAll(estudiantes);
    listaTareas.addAll(tareas);
    listaTareasAsignadas.addAll(tareasAsignadas);

    estudiante = listaEstudiantes.first;
    actualizarListaTareasCompletadas(estudiante!);
    actualizarListaTareasNoCompletadas(estudiante!);
  }

  @override
  _SeguimientoEstudianteState createState() => _SeguimientoEstudianteState();
}

class _SeguimientoEstudianteState extends State<SeguimientoEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

  // Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  /*
   * Devuelve un Widget para mostrar el menú de seguimiento del alumno, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre del alumno (Dropdown)
   *    2. Lista de tareas asignadas completadas
   *    3. Lista de tareas asignadas no completadas
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: const Text("Seguimiento de Alumno"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child:
              Row(
                children: [
                  Icon(Icons.person,color: Colors.blue),
                  Text("Alumno: ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, 0, separacionElementos, 0.0),
                margin: const EdgeInsets.all(10),
                child: DropdownButton(
                  value: estudiante!.nombre,
                  isExpanded: true,
                  items: listaEstudiantes.map<DropdownMenuItem<String>>((Estudiante e) {
                    return DropdownMenuItem<String>(
                      value: e.nombre,
                      child: Text(e.nombre + " " + e.apellidos),
                    );
                  }).toList(),
                  onChanged: (String? nombre) {
                    setState(() {
                      estudiante = buscarEstudiante(nombre!);
                      actualizarListaTareasCompletadas(estudiante!);
                      actualizarListaTareasNoCompletadas(estudiante!);
                    });
                  },
                )
            ),

            //Contenedor para tareas asignadas y completadas
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tareas asignadas completadas: " + listaTareasCompletadas.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Column(
                    children: listaTareasCompletadas.map((tarea) {
                      return Container(
                        padding: EdgeInsets.all(separacionElementos),
                        child: Text(tarea.nombre, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tareas asignadas no completadas: " + listaTareasNoCompletadas.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Column(
                    children: listaTareasNoCompletadas.map((tarea) {
                      return Container(
                        padding: EdgeInsets.all(separacionElementos),
                        child: Text(tarea.nombre, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ], // children
        ),
      ),
    );
  }
}