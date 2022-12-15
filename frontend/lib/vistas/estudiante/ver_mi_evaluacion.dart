import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';


List<Estudiante> listaEstudiantes = [];
List<Tarea> listaTareas = [];
List<TareaAsignada> listaTareasAsignadas = [];
List<Tarea> listaTareasCompletadas = [];
List<Tarea> listaTareasNoCompletadas = [];

Estudiante? estudiante = ;

String? getTipoAccesibilidad(Estudiante? estudiante)
{
  String? tipoAccesibilidad = " ";
  if(estudiante?.accesibilidad == Null)
    tipoAccesibilidad = "sin_especificar";
  else
    tipoAccesibilidad = estudiante?.accesibilidad;

  return tipoAccesibilidad;
}

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
    if(tAux.idTarea == idTarea)
      t = tAux;

  return t;
}

TareaAsignada buscarTareaAsignada(String idTarea, String idEstudiante) {
  TareaAsignada ta = listaTareasAsignadas.first;

  for (TareaAsignada taAux in listaTareasAsignadas)
    if(taAux.idTarea == idTarea && taAux.idEstudiante == idEstudiante)
      ta = taAux;

  return ta;
}

void actualizarListaTareasCompletadas(Estudiante e) {
  listaTareasCompletadas.clear();

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "1" && ta.idEstudiante == e.idEstudiante)
      listaTareasCompletadas.add(buscarTarea(ta.idTarea));
}

void actualizarListaTareasNoCompletadas(Estudiante e) {
  listaTareasNoCompletadas.clear();

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "0" && ta.idEstudiante == e.idEstudiante)
      listaTareasNoCompletadas.add(buscarTarea(ta.idTarea));
}

int numTareasBien() {
  int contador = 0;

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "1" && ta.calificacion == "Bien" && ta.idEstudiante == estudiante!.idEstudiante)
      contador++;

  return contador;
}

int numTareasMuyBien() {
  int contador = 0;

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "1" && ta.calificacion == "Muy bien" && ta.idEstudiante == estudiante!.idEstudiante)
      contador++;

  return contador;
}

String evaluacionMedia() {
  int numBien = numTareasBien();
  int numMuyBien = numTareasMuyBien();
  int numNormal = listaTareasCompletadas.length - numMuyBien - numMuyBien;

  double mediaMuyBien = 1.0;
  double mediaBien = 0.5;
  double mediaNormal = 0.0;

  double media = ((numNormal * mediaNormal + numBien * mediaBien + numMuyBien * mediaMuyBien) / 3);
  String evaluacion = "";

  if (media >= 0.75)
    evaluacion = "Muy bien";
  else if (media >= 0.5)
    evaluacion = "Bien";
  else
    evaluacion = "Normal";

  return evaluacion;
}

/*
 * Clase Seguimiento hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class VerMiEvaluacion extends StatefulWidget {
  VerMiEvaluacion(List<Estudiante> estudiantes, List<Tarea> tareas, List<TareaAsignada> tareasAsignadas) {
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
  _VerMiEvaluacionState createState() => _VerMiEvaluacionState();
}


class _VerMiEvaluacionState extends State<VerMiEvaluacion> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

  // Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: const Text("Ver mi evaluacion"),
      ),
      body: SafeArea(
        child:(id)
        ),
    );
  }
}