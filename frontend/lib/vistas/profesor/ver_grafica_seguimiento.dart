
import 'package:app/clases/estudiante.dart';
import 'package:flutter/material.dart';
import '../../clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';

Estudiante? estudiante;

List<TareaAsignada> listaTareasAsignadas = [];


List<TareaAsignada> listaTareasCompletadas = [];
List<TareaAsignada> listaTareasNoCompletadas = [];


class GraficaSeguimiento extends StatefulWidget {

  GraficaSeguimiento(Estudiante e, List<Tarea> listaTareasAsignadas){
    estudiante = e;
    listaTareasAsignadas.addAll(listaTareasAsignadas);
  }


  @override
  _GraficaSeguimientoState createState() => _GraficaSeguimientoState();
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
      listaTareasCompletadas.add(buscarTareaAsignada(ta.idTarea, e.idEstudiante));
}

void actualizarListaTareasNoCompletadas(Estudiante e) {
  listaTareasNoCompletadas.clear();

  for (TareaAsignada ta in listaTareasAsignadas)
    if (ta.completada == "0" && ta.idEstudiante == e.idEstudiante)
      listaTareasNoCompletadas.add(buscarTareaAsignada(ta.idTarea,e.idEstudiante));
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



void generar_grafico(){


}


class _GraficaSeguimientoState extends State<GraficaSeguimiento> {
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
        title: const Text("Gráfica de seguimiento"),
      ),
      body: SafeArea(


      ),
    );
  }
}