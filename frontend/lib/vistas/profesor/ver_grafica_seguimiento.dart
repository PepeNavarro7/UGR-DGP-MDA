
import 'dart:ffi';

import 'package:app/clases/estudiante.dart';
import 'package:flutter/material.dart';
import '../../clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Estudiante? estudiante;

List<TareaAsignada> listaTareasAsignadas = [];


List<TareaAsignada> listaTareasCompletadas = [];
List<TareaAsignada> listaTareasNoCompletadas = [];




class PuntoDeGrafica {
  final int nota;
  final int tarea;

  PuntoDeGrafica(this.nota, this.tarea);
}


class SimpleLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, dynamic>> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData() {
    return SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> seriesListChart = [];
    seriesList.forEach((element) {
      charts.Series<dynamic, int> aux = charts.Series(id: 'Evaluacion de notas' , data: [], domainFn: element.data.first, measureFn: element.data.last);
      aux.data.first = element.data.first;
      aux.data.last = element.data.last;
      seriesListChart.add(aux);
    });

    return new charts.LineChart(seriesListChart, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PuntoDeGrafica, dynamic>> _createSampleData() {


    final datos = [ new PuntoDeGrafica(0, 0)];
    datos.removeAt(0);
    int nota = -1;
    int i = 0;
    listaTareasAsignadas.forEach((element) {
      ++i;
      switch (element.calificacion){
        case "Muy Bien":
          nota = 3;
          break;
        case "Bien":
          nota = 2;
          break;
        case "Normal":
          nota = 1;
          break;
        case "Pendiente":
          nota = 0;
          break;
      }

      datos.add(new PuntoDeGrafica(nota, i));
    });

    return [
      charts.Series<PuntoDeGrafica, dynamic>(
        id: 'Evaluacion de notas',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PuntoDeGrafica punto, _) => punto.nota,
        measureFn: (PuntoDeGrafica punto, _) => punto.tarea,
        data: datos,
      )
    ];
  }
}



class GraficaSeguimiento extends StatefulWidget {

  GraficaSeguimiento(Estudiante e, List<Tarea> listaTareasAsignadas){
    estudiante = e;
    listaTareasAsignadas.addAll(listaTareasAsignadas);
    actualizarListaTareasCompletadas(e);
    actualizarListaTareasNoCompletadas(e);

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


int numTareasNormal() {
  return (listaTareasCompletadas.length - numTareasMuyBien() - numTareasBien());
}



String evaluacionMedia() {
  int numBien = numTareasBien();
  int numMuyBien = numTareasMuyBien();
  int numNormal = numTareasNormal();
  int numNoCompletada = listaTareasNoCompletadas.length;

  int mediaMuyBien = 8;
  int mediaBien = 6;
  int mediaNormal = 4;
  int mediaNoCompletada = 1;

  double media = ( (numNoCompletada  * mediaNoCompletada + numNormal * mediaNormal + numBien * mediaBien + numMuyBien * mediaMuyBien)
      / listaTareasAsignadas.length );
  String evaluacion = "";

  if (media >= 7)
    evaluacion = "Muy bien";
  else if (media >= 5)
    evaluacion = "Bien";
  else if (media >= 3)
    evaluacion = "Normal";
  else
    evaluacion = "No completadas";

  return evaluacion;
}

double porcentajeTareas(String tipo){

  double porcentaje = -1;
  int numAsignadas = listaTareasAsignadas.length;
  int numCompletadas = listaTareasCompletadas.length;
  int numNoCompletadas = listaTareasNoCompletadas.length;

  switch(tipo){
    case "Completadas":
      porcentaje = numCompletadas*100 / numAsignadas;
      break;

    case "No Completadas":
      porcentaje = numNoCompletadas*100 / numAsignadas;
      break;

    case "Muy Bien":
      porcentaje = numTareasMuyBien()*100 / numCompletadas;
      break;

    case "Bien":
      porcentaje = numTareasBien()*100 / numCompletadas;
      break;

    case "Normal":
      porcentaje = numTareasNormal()*100 / numCompletadas;
      break;
  }

  return porcentaje;
}

void generar_grafico(){

  //En orden de tareas asignadas, codificar con 0 no realizada, 1 realizada, 2 Bien, 3 Muy Bien
  List<int> evaluaciones = [listaTareasAsignadas.length];

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
          child: ListView(
              children: [


                Container(
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Número de tareas asignadas: " + listaTareasAsignadas.length.toString(), style: TextStyle(fontSize: 20)),
                      Text("Número de tareas completadas: " + listaTareasCompletadas.length.toString(), style: TextStyle(fontSize: 20)),
                      Text("Número de tareas no completadas: " + listaTareasNoCompletadas.length.toString(), style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),


                //////////GRAFICO//////////

                ///////////////////////////


                Container(
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("% de tareas completadas: " + porcentajeTareas("Completadas").toString(), style: TextStyle(fontSize: 20)),
                      Text("% de tareas no completadas: " + porcentajeTareas("No Completadas").toString(), style: TextStyle(fontSize: 20)),

                      Text("\nNúmero de tareas evaluadas Muy Bien: " + numTareasMuyBien().toString(), style: TextStyle(fontSize: 20)),
                      Text("Número de tareas evaluadas Bien: " + numTareasBien().toString(), style: TextStyle(fontSize: 20)),
                      Text("Número de tareas evaluadas Normal: " + numTareasNormal().toString(), style: TextStyle(fontSize: 20)),

                      Text("\n% de tareas evaluadas Muy Bien: " + porcentajeTareas("Muy Bien").toString(), style: TextStyle(fontSize: 20)),
                      Text("% de tareas evaluadas Bien: " + porcentajeTareas("Bien").toString(), style: TextStyle(fontSize: 20)),
                      Text("% de tareas evaluadas Normal: " + porcentajeTareas("Normal").toString(), style: TextStyle(fontSize: 20)),

                      Text("\nEvaluación media: " + evaluacionMedia(), style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),


              ])
      ),
    );
  }
}